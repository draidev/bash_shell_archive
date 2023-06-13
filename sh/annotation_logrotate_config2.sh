!/bin/bash

if [ -e /etc/cron.daily/logrotate ]; then
    if grep -q -F "/run/systemd/system" /etc/cron.daily/logrotate; then
        if ! grep -q "^#" <<< "$(sed -n "4,6p" /etc/cron.daily/logrotate)"; then
            sed -i "4,6s/^/#/" /etc/cron.daily/logrotate
        fi  
    fi  
fi
