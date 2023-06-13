#!/bin/bash                                             
                                                        
logrotate=/etc/cron.daily/logrotate                     
cat_logrotate=$(cat /etc/cron.daily/logrotate)          
system_line=/run/systemd/system                         
grep_system_line=$(grep -nF "$system_line" $logrotate)  
line_num=$(echo "$grep_system_line" | cut -d : -f1)     
line_num_2=$((line_num + 2))                            
                                                        
if [ -e $logrotate ]; then                              
    if grep -q -F "$system_line" $logrotate ; then      
        if ! grep -q "^#" <<< "$(sed -n "${line_num},${line_num_2}p" $logrotate)"; then
            echo "$cat_logrotate" | sed "${line_num},${line_num_2}s/^/#/" > /etc/cron.daily/logrotate
        fi  
    fi
fi   
