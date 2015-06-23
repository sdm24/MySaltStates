## This state will install and configure Pure-ftpd and create ftpgroup and ftpuser
## To add virtual users to Pure-ftpd, run the user state located in this directory
## If you manually add users using 'pure-pw useradd', include -m at the end or run 'pure-pw mkdb' after.

Install Pure-ftpd:
  pkg.installed:
    - name: pure-ftpd
  service.running:
    - name: pure-ftpd
    - enable: True
    - require:
      - pkg: pure-ftpd

Create ftpgroup group:
  group.present:
    - name: ftpgroup
    - gid: 1005

Create ftpuser user:
  user.present:
    - name: ftpuser
    - gid: 1005
    - home: /dev/null
    - shell: /etc
    - groups:
      - ftpgroup
    - createhome: False

Make ftpuser home dir:
# Even though ftpuser's home is /dev/null, /home/ftpuser needs to exist for virtual users
  file.directory:
    - name: /home/ftpuser
    - user: ftpuser
    - group: ftpgroup
    - recurse:
        - user
        - group
        - mode

Set configs:
# Because pureFTP does not have one config file, each option must be created as its own file
  cmd.run: 
    - name: |
        echo 'clf:/var/log/pure-ftpd/transfer.log' > AltLog
        echo 'UTF-8' > FSCharset
        echo '1000' > MinUID
        echo 'yes' > NoAnonymous
        echo 'yes' > PAMAuthentication
        echo '/etc/pure-ftpd/pureftpd.pdb' > PureDB
        echo 'no' > UnixAuthentication
    - cwd: /etc/pure-ftpd/conf
