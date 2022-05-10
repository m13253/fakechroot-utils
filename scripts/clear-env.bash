#!/bin/bash

# Although newer versions of bubblewrap comes with "--clearenv" option,
# if you happen to only have an older version, here is the script.
# To use this script, write ". reset-env.bash" in your ~/.bashrc file.

if [[ $- = *i* ]]
then
    export PATH=/usr/local/sbin:/usr/local/bin/:/usr/bin
    export SHELL=/bin/bash
    while read VAR_NAME
    do
        unset "$VAR_NAME"
    done < <(env | cut -d = -f 1 | grep -v '^\(EDITOR\|HOME\|LANG\|LC_.*\|PAGER\|PATH\|PWD\|SHELL\|SHLVL\|SSH_.*\|TERM\|TZ\|USER\)$')
fi
