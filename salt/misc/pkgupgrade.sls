## This state will upgrade the packages on a linux minion

Update packages:
  module.run:
    - name: pkg.upgrade
    - refresh: True
