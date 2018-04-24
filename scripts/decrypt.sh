#!/bin/bash

decrypt()
{
	if [ ! -f "$1.encrypted" ]
	then
		printf "%-60s   [ \033[31mNot found  \033[0m]\n" "$1"
		return 0
	fi

	if [ ! -f "$2" ]
	then
         printf "%-60s   [ \033[93mSkipped - No key \033[0m]\n" "$1"
		 return 0
	fi

	decrypted=$(openssl aes-256-cbc -d -a -in $1.encrypted -pass file:$2 2>/dev/null)
	old_file=$(cat $1 2>/dev/null)

	if [ "$decrypted" != "$old_file" ]
	then
		openssl aes-256-cbc -d -a -salt -in ${1}.encrypted -out ${1} -pass file:${2} 2>/dev/null

		if [ $? == 0 ]
		then
			printf "%-60s   [ \033[92mDecrypting\033[0m ]\n" "$1"
		else
			printf "%-60s   [ \033[91mError decrypting\033[0m ]\n" "$1"
		fi
	else
		printf "%-60s   [ No changes ]\n" "$1"
	fi
}

if [ -d "configs/local" ]
then
	for file in $(find configs/local -name \*secrets.json.encrypted); do
		output_file=$(echo "${file}" | sed  's/\.encrypted//g')

		decrypt ${output_file} ${HOME}/.pass_local
	done
fi

if [ -d "configs/prod" ]
then
	for file in $(find configs/prod -name \*secrets.json.encrypted); do
		output_file=$(echo "${file}" | sed  's/\.encrypted//g')

		decrypt ${output_file} ${HOME}/.pass_prod
	done
fi