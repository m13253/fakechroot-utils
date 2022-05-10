#!/usr/bin/fish

# Although newer versions of bubblewrap comes with "--clearenv" option,
# if you happen to only have an older version, here is the script.
# To use this script, put this script to ~/.config/fish/conf.d/ directory.

if status is-interactive
    set -x PATH /usr/local/sbin /usr/local/bin/ /usr/bin
    env | cut -d = -f 1 | string match -r -v '^(?:EDITOR|HOME|LANG|LC_.*|PAGER|PATH|PWD|SHELL|SHLVL|SSH_.*|TERM|TZ|USER)$' |
    while read VAR_NAME
        set -e $VAR_NAME
    end
end
