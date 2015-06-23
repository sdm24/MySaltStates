# This state installs vim on Windows machines using chocolatey, if it is not already installed
# It will also install chocolatey if it is not already found

include:
  - misc.chocolatey

Install vim:
  module.run:
    - name: chocolatey.install
    - m_name: vim 
    - unless: dir "C:\Program Files (x86)\vim\"