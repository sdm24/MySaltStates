This state will install apache and manage its sites. Sites are created by hand and placed into the templates/sites/ directory.
More help with this state can be found on the KB at [Managing Apache With Salt] (http://wiki.example.com/display/Group/Managing+Apache+With+Salt)

**init.sls:** installs and configures apache web server.

**manage.sls:** Uses for-loops to make sure that the apache servers have the correct sites and mods enabled, as set in /srv/pillar/top.sls
If the ssl mod is included, it will make sure that the SSL certs and keys are set up correctly. 

**templates:** contains **Ubuntuapache2.conf** and **Debianapache2.conf**, which are used as apache's config files. 
**site.conf** is a template that can be used to make other .conf templates. 
**sites** contains all of the .conf files for sites and **certs** contains the SSL certs and keys.