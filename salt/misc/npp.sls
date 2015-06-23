# This state will install Notepad++ on a Windows minion
# If this state fails, make sure to run "salt <targetedminions> pkg.refresh_db" and retry installing the package

install Notepad++:
  pkg.installed:
    - name: npp
