Splunk:
  6.2.2.255606:
    installer: 'salt://files/windows/splunk/splunkforwarder-6.2.2-255606-x64-release.msi'
    full_name: UniversalForwarder
    reboot: False
    install_flags: ' DEPLOYMENT_SERVER="splunkdep.example.com:8089" LAUNCHSPLUNK=0 AGREETOLICENSE=Yes /quiet'
    msiexec: True
    uninstaller_flags: '/quiet'
