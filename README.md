Backup ~/mhuston to gitlab

===================





This is a repo to backup my home directory after a rsync

----------





Prerequisites

-------------



This is presuming your are using an IFDC RHEL VDI



> **Note:**



> - Create a directory named $USER_home a path above your home drectory 

> - i.e. sudo mkdir /home/mhuston_home

> - Create a symlink to this directory in $HOME

> - ln -s /home/mhuston_home mhuston_home

> - Create a directory for rsyncing your home

> - mkdir /home/mhuston_home/RSYNC_POWER_OUTAGE

> - rsync your $home to the above created directory

> -  rsync -avzh /home/mhuston /home/mhuston_home/RSYNC_POWER_OUTAGE/

> - chef generate cookbook && chef generate attribute default

> - use gitlab to create a new project, and replace the .git foilder within your end destination

> - git add .  && git commit -a -m "comment"

> - git status

> - git push -u origin master

> - I prefer to add some aliases to ~/.bashrc

> - alias reload='source ~/.bashc && source ~/.bash_profile'

> - alias backup='rsync -avzh /home/mhuston /home/mhuston_home/RSYNC_POWER_OUTAGE/'

>- alias SSL='/opt/sslvpn-plus/naclient/login status'


#### <i class="icon-file"></i> Backup and commit daily

>- crafted a simple script to automate this all and alias the below script

>- See ~/bang.sh for script and chmod < 755

>- alias bang='/home/mhuston/bang.sh'

>- crontab -e

>- This will run at 12:22 am UTC every day

>- 22 0 * * * /home/mhuston/bang.sh | while IFS= read -r line; do printf "%s %s\n" "$(date)" "$line"; done >> /home/mhuston/crontab.log
