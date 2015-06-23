This state will install and configure postfix mail client. Any emails sent to a configured VM will be sent to errors@example.com instead

This state will not run if the directory '/opt/zimbra' exists

**templates** contains templates for /etc/mailman/, etc/postfix/aliases, and /etc/postfix/main.cf and /etc/postfix/master.cf for debian and ubuntu machines.