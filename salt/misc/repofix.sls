# This state will fix the error when Windows machines will not install programs from the Windows Repo
# After it changes the targeted minions' configuration file, it will restart the minions
# This state will only run when it is manually called

fix minion repo:
  file.replace:
    - name: C:\salt\conf\minion
    - pattern: '.*win_repo_cachefile:.*'
    - repl: "win_repo_cachefile: 'salt://files/windows/repo/winrepo.p'"

restart windows minion:
  cmd.run:
    - name: 'start powershell "Restart-Service -Name salt-minion"'


