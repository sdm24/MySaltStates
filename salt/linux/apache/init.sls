## This state will install Apache2 and load a default configuration

Install Apache:
  pkg.installed:
    - name: apache2
  service.running:
    - name: apache2
    - enable: True
    - watch: 
      - file: 'Set apache2.conf'

Set apache2.conf:
  file.managed:
    - name: /etc/apache2/apache2.conf
    - source: salt://linux/apache/templates/{{ grains['os'] }}apache2.conf
    - makedirs: True
    - backup: minion  
