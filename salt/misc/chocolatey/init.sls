# This state install chocolatey, a package manager for Windows

Install chocolatey:
 module.run:
    - name: chocolatey.bootstrap
    - stateful: True
