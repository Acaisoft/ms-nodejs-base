#!/bin/bash

encrypt()
{
    if [ ! -f "$2" ]
    then
         printf "%-60s   [ \033[93mSkipped - No key \033[0m]\n" "$1"
    else
        decrypted=$(openssl aes-256-cbc -d -a -in $1.encrypted -pass file:$2 2>/dev/null)
        new_file=$(cat $1)

        if [ "$decrypted" != "$new_file" ]
        then
            printf "%-60s   [ \033[92mEncrypting \033[0m]\n" "$1"
            openssl aes-256-cbc -a -in $1 -out $1.encrypted -pass file:$2
        else
            printf "%-60s   [ No changes ]\n" "$1"
        fi
    fi
}

if [ -d "configs/local" ]
then
	for file in $(find configs/local -name \*secrets.json); do
		encrypt ${file} ${HOME}/.pass_local
	done
fi

if [ -d "configs/prod" ]
then
	for file in $(find configs/prod -name \*secrets.json); do
		encrypt ${file} ${HOME}/.pass_prod
	done
fi