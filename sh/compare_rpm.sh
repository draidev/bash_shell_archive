#!/bin/bash

# path
LEGACY_LOG_PATH=/var/lib/jenkins/jobs/lockard_rpm_cd/builds/$1/log
NEW_LOG_PATH=/var/lib/jenkins/jobs/lockard_rpm_cd/builds/$2/log


# get rpm packages list
LEGACY_SHA1SUM=$(grep "+ sha1sum" $LEGACY_LOG_PATH)
NEW_SHA1SUM=$(grep "+ sha1sum" $NEW_LOG_PATH)

LEGACY_TAR_STR=$(echo $LEGACY_SHA1SUM | cut -d ' ' -f3-)
NEW_TAR_STR=$(echo $NEW_SHA1SUM | cut -d ' ' -f3-)

LEGACY_TAR_ARR=($LEGACY_TAR_STR)
NEW_TAR_ARR=($NEW_TAR_STR)


# get length of rpm package array
LEGACY_COUNT=$((${#LEGACY_TAR_ARR[@]}))
NEW_COUNT=$((${#NEW_TAR_ARR[@]}))
# get index for use in loop
SET=$(seq 0 $(($NEW_COUNT - 1)))


# Error handling
if [[ $LEGACY_COUNT != $NEW_COUNT ]]; then
	echo -e "\033[31mThe number of rpm packages is different.\nor build number is incorrect.\nPlease check build number.\033[0m"

	echo -e "\n\033[31m** exit 1 **\033[0m\n"
	exit 1
fi


# compare hash
num=0
for i in $SET
do
	LEGACY_HASH=$(grep ${LEGACY_TAR_ARR[$i]} $LEGACY_LOG_PATH | grep -v "+" | grep -v "cp -f" | cut -d ' ' -f1)
	NEW_HASH=$(grep ${NEW_TAR_ARR[$i]} $NEW_LOG_PATH | grep -v "+" | grep -v "cp -f" | cut -d ' ' -f1)

	if [[ $LEGACY_HASH != $NEW_HASH ]];
       	then
		#echo -e "${NEW_TAR_ARR[$i]} \033[31mhas been changed!!\033[0m"
		CHANGED_ARR[$num]=${NEW_TAR_ARR[$i]}
		num=$(($num+1))
	fi
done


# display result
if [[ $num -eq 0 ]]
then
	echo -e "\033[31mNothing has changed!!\033[0m\n"
else
	echo -e "\n"
	echo -e "\033[31m=======================================================================\033[0m"
	echo -e "                  \033[31m$num\033[0m rpm packages have been changed!!"
	echo -e "\033[31m=======================================================================\033[0m"
	echo -e "\n"
	for value in "${CHANGED_ARR[@]}"
	do
		echo -e "\033[32m$value\033[0m"
	done
	echo -e "\n"
	echo -e "\033[31m=======================================================================\033[0m"
	echo -e "\033[31m=======================================================================\033[0m"
	echo -e "\n\n"
fi	
