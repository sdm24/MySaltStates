Salt-Minion:
  2014.7.5:
    installer: 'salt://files/windows/salt/Salt-Minion-2014.7.5-AMD64-Setup.exe'
    full_name: 'Salt Minion 2014.7.5'
    reboot: False
    install_flags: ' /S'
    uninstaller: 'C:\salt\uninst.exe'
    uninstall_flags: ' /S'
    refresh: True
  2014.7.2:
    installer: 'https://docs.saltstack.com/downloads/Salt-Minion-2014.7.2-AMD64-Setup.exe'
    full_name: 'Salt Minion 2014.7.2'
    reboot: False
    install_flags: ' /S'
    uninstaller: 'C:\salt\uninst.exe'
    uninstall_flags: '/S'
    refresh: True