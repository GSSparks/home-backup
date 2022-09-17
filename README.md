# home-backup
Bash script that will back up your Documents, Pictures, and Videos directories in your home directory if a file change is detected.

Needs to be ran by the user whose home directories you want to back up. For example, if you run this script using a systemd timer then you run this with 'sudo -u USER'. 

Backup Directory is set by adding the PATH when running the script. For example you would write, "sudo -u USER ./home-backup.sh /mnt/backup"
