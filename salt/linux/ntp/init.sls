## This state will install and configure Network Time Protocol (NTP) Server
## Once the service restarts, it may take a few minutes for the clients to reconnect
## The service will only restart if ntp.conf is changed

Install ntp:
  pkg.installed:
    - name: ntp

Start or Restart ntp:
# NTP will restart only if Salt makes any changes to ntp.conf
  service.running:
    - name: ntp
    - enable: True
    - watch:
      - file: 'Manage ntp.conf'

Manage ntp.conf:
  file.managed:
    - name: /etc/ntp.conf 
    - source: salt://linux/ntp/templates/{{ grains['host'] }}ntp.conf
#   ntp1 and ntp2 have different conf files templates, ntp1 will use its local clock as a backup
    - template: jinja
    - backup: minion
