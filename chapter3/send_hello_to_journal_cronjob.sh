#!/bin/sh
# Every minute, send a hello message to the systemd journal.
#
# To install the script into your servers, run the following ansible commands:
# 1. copy the file into the vagrant home directory of the target machines
# 2. make the script executable
# 3. install the cron job for the vagrant user to run the script every minute
#
# ansible multi -m copy -a "src=./send_hello_to_journal_cronjob.sh dest=/home/vagrant/send_hello_to_journal_cronjob.sh"
# ansible multi -b -m file -a "path=/home/vagrant/send_hello_to_journal_cronjob.sh mode=0755 owner=vagrant group=vagrant"
# ansible multi -b -m cron -a "name='send_hello_to_journal' minute='*' user=vagrant job='/home/vagrant/send_hello_to_journal_cronjob.sh'"
#
# You can validate the installation by checking the crontab of the vagrant user:
# ansible multi -m shell -a "crontab -l"
#
# After having installed the job, you can check the journal with:
# ansible multi -b -m shell -a "journalctl --lines=20 | grep 'Hello.*personal cron job'"
#
# To uninstall the cronjob, issue
# ansible multi -b -m cron -a "name='send_hello_to_journal' user=vagrant state=absent"
#
SCRIPT_NAME=$(basename "$0")
echo "Hello $USER, this is your personal cron job." | systemd-cat -t "$SCRIPT_NAME" -p info
