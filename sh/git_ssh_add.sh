#!/bin/bash
# git ssh 패스워드 등록

eval "$(ssh-agent -s)"

expect -c "
set timeout 5
spawn ssh-add ~/.ssh/id_rsa
expect \"passphrase\"
send \"jjy31025!\n\"
exit 0
"
