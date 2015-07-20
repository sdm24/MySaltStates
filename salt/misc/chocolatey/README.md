To install chocolatey on a windows minion, run "salt [target minion] state.sls misc.chocolatey"

To install packaged programs, run "salt [target minion] state.sls misc.chocolatey.[packagename]
Ex: to install vim on "saltwintest", type "salt saltwintest state.sls misc.chocolatey.vim"
When a package is installed, Salt will make sure chocolatey is installed first.

**Contained Packages:**
Vim