rsyslog will install and configure the rsyslog package, and then start the service. If it detects that changes were made to any of the managed files, the service will restart.

If the minion's hostname starts with "mail", Salt will use the special mail50-default.conf template to update 50-default.conf

**templates** contains templates to manage /etc/rsyslog/ etc/logrotate.d/rsyslog, etc/rsyslog.d/50-default.conf, and etc/rsyslog.d/mail50-default.conf