#!/bin/bash

flag=0

auto_commit()
{
	baseDir=$1
	cd ${baseDir}

	filePath=`git status -u -s | head -n 1`
	filePath=${filePath:3}

	if [ -z "$filePath" ]; then
	    echo '##### file not found #####'
		((flag+=1))
		echo "#flag : $flag"
		return
	fi

	tempfilepath="/home/drtkdldjstm/temp.txt"
	if [ $2 -eq 0 ]; then
		commitMsg=`cat $filePath | head -1`
	elif [ $2 -eq 1]; then
		commitMsgfile="/home/drtkdldjstm/Mal_commitMsg.txt"

		commitMsg=`cat $commitMsgfile | head -n 1`
		echo "#cm $commitMsg"
		cat $commitMsgfile > $tempfilepath
		tail -n +2 $tempfilepath > $commitMsgfile
		rm $tempfilepath
	elif [ $2 -eq 2 ]; then
		commitMsgfile="/home/drtkdldjstm/Bash_commitMsg.txt"

		commitMsg=`cat $commitMsgfile | head -n 1`
		echo "#cm $commitMsg"
		cat $commitMsgfile > $tempfilepath
		tail -n +2 $tempfilepath > $commitMsgfile
	else
		echo "##### nothing to process!! #####"
		exit
	fi

	if [ -e "$tempfilepath" ]; then
		rm $tempfilepath
	fi

	echo "commit Message : $commitMsg"

	git add $filePath 
	git status
	git commit -m "${commitMsg}"
	git push
}


echo '##### auto push start #####'

python_path="/home/drtkdldjstm/Python_algorithm"
malware_path="/home/drtkdldjstm/malware_detection_package"
bash_path="/home/drtkdldjstm/bash_shell_archive"

auto_commit $python_path $flag
auto_commit $malware_path $flag
auto_commit $bash_path $flag

echo '##### auto push end #####'
~    
