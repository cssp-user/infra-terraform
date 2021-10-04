#cloud-config
repo_update: true
repo_upgrade: all

write_files:
- path: /home/centos/packages.sh
  permissions: '0755'
  content: |
     #!/bin/bash
       sudo yum install git -y
       sudo yum install epel-release -y
       sudo yum install ansible -y
       sudo yum install docker -y
       sudo systemctl start docker
       sudo groupadd docker
       sudo usermod -aG docker $USER
       sudo chmod 777 /var/run/docker.sock

- path: /home/centos/ssh_keys.sh
  permissions: '0755'
  content: |
     #!/bin/bash
     ssh-keygen -q -t rsa -N '' -f /home/centos/.ssh/id_rsa <<<y 2>&1 >/dev/null

     cat /home/centos/.ssh/id_rsa.pub >> /home/centos/.ssh/authorized_keys

     ssh -o StrictHostKeyChecking=no centos@localhost
     
- path: /home/centos/play-books.sh
  permissions: '0755'
  content: |
     #!/bin/bash
     git clone https://github.com/cssp-user/conf-ansible.git

     cd conf-ansible/plays

     ansible-playbook -i hosts devstack.yml


runcmd:
# - [ sh, /home/centos/packages.sh ]
# - [ sh, /home/centos/ssh_keys.sh ]
# - [ sh, /home/centos/play_books.sh ]

