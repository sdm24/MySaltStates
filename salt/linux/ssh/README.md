This state install both openssh-client and openssh-server and loads their configurations from template files stored on the master.

**init.sls:** This will install openssh-client and make sure that the config file matches the template. It also includes server.sls

**server.sls**: This will install openssh-server and configure it with the template file.

**templates** contains the server configuration templates **Ubuntu_sshd_config** for Ubuntu servers, **Debian_sshd_config** for Debian servers, and client configuration template **ssh_config**.

Ubuntu_sshd_config adds etc/ssh/ssh_host_ed25519 as a Host key, while Debian_sshd_config does not have that line.