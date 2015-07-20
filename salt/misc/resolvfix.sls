# This state will updated /etc/resolv.conf to add prod.example.com as a search domain
# It will only run if the target minion is on the example.com domain
# This state should only be run on linux minions 

{% if grains['domain'] == 'example.com' %}
Add prod.example.com to search:
  file.replace:
    - name: /etc/resolv.conf
    - pattern: 'search example.com'
    - repl: 'search example.com prod.example.com'
{% endif %}

    
