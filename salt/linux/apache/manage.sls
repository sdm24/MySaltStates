## This state will manage the apache host.conf files and mods
## It will restart apache if any new hosts are added
## It should be run on the apache targets
## It uses pillar data in a for-loop to determine which sites/mods to load
## Make sure that the pillar data for each server is correct in /srv/pillar/top.sls
##   and that the proper site template exists in /srv/salt/linux/apache/templates/sites/

include:
  - linux.apache
 
apache2:
  service.running:
    - enable: True
    - order: last    

## Check and enable sites
{% if pillar['sites'] is defined %}
{% for site, status in pillar['sites'].iteritems() %}
Check {{ site }}.conf in sites-available:
  file.managed:
    - name: '/etc/apache2/sites-available/{{ site }}.conf'
    - source: salt://linux/apache/templates/sites/{{ site }}.conf
    - watch_in:
      - service: apache2
    - backup: minion
Enable {{ site }}:
  cmd.run:
    - name: 'a2ensite {{ site }}.conf' 
{% endfor %} 
{% endif %}

## load mods, if any exist
{% if pillar['mods'] is defined %}
{% for mod, status in pillar['mods'].iteritems() %} 
Enable {{ mod }} mod:
  apache_module.enable:
    - name: {{ mod }} 
{% endfor %}
{% endif %}

{% if 'ssl' in salt['pillar.get']('mods') %}
Check SSL keys and certs:
  file.recurse:
    - name: /etc/ssl/private
    - source: salt://linux/apache/templates/certs
{% endif %}
