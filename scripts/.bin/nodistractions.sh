#!/bin/sh

# If you want to allow some websites/IPs to still work
# after adding the filters, just add specific rules to
# iptables to allow it. For instance:
#
# sudo iptables --insert OUTPUT --protocol tcp --destination 138.4.0.0/16 --jump ACCEPT 
#
# iptables rules are interpreted top to bottom.
# --append adds rules to the end of the file
# --insert adds rules to the top of the file
# Hence, you can either append the rule before running
# the script, or insert the rule so it takes precedence.
 
export SUDO_ASKPASS=/usr/lib/ssh/ssh-askpass
CMD="sudo -A iptables"
RULE="OUTPUT --protocol tcp --jump DROP --dport"

stop_filter() {
    $CMD --delete $RULE 80
    $CMD --delete $RULE 443
}

filter() {
    stop_filter >&2 /dev/null # Avoid re-adding
    $CMD --append $RULE 80
    $CMD --append $RULE 443
}


help() {
    echo "Usage: $0 on|off"
}

if [ "$#" -ne 1 ]; then
    filter
else
    case "$1" in
        "on")
            filter
            ;;
        "off")
            zenity --question --text="Are you sure you want to let distractions in?" && stop_filter
            ;;
        *)
            help
    esac
fi

