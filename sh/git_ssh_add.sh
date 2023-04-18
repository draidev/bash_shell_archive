#!/bin/bash
# git ssh 패스워드 등록

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa_draidev
