#!/bin/sh

# This script will block all traffic to ports 80 and 443.
#
# If you want to allow some websites/IPs to still work
# after adding the filters.
#
# Set the $ALLOWED_DEST variable to the network/mask you want to accept
#
#
# Another option is to add specific rules to
# iptables to allow it. For instance:
#
# sudo iptables --insert OUTPUT --protocol tcp --destination 138.4.0.0/16 --jump ACCEPT 
#
# iptables rules are interpreted top to bottom.
# --append adds rules to the end of the file
# --insert adds rules to the top of the file
# Hence, you can either append the rule before running
# the script, or insert the rule so it takes precedence.
 
ALLOWED_DEST=${ALLOWED_DEST:=138.4.0.0/16} 
export SUDO_ASKPASS=/usr/lib/ssh/ssh-askpass
CMD="sudo -A iptables"
RULE="OUTPUT --protocol tcp --jump DROP --dport"
ALLOW_RULE="OUTPUT --protocol tcp --jump ACCEPT --destination $ALLOWED_DEST"


stop_filter() {
    $CMD --delete $RULE 80
    $CMD --delete $RULE 443
    $CMD --delete $ALLOW_RULE
}

filter() {
    stop_filter >&2 /dev/null # Avoid re-adding
    $CMD --append $RULE 80
    $CMD --append $RULE 443
    $CMD --insert $ALLOW_RULE

}


help() {
    echo "Block all traffic to ports 80 and 443"
    echo ""
    echo "Usage: $0 on|off"
    echo ""
    echo "Set the ALLOWED_DEST variable to whitelist some IPs/network"
    echo "Currently whitelisted: $ALLOWED_DEST"
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

