#!/bin/bash

# BASIC REQUIREMENTS & INFO:
# 1. When starting without parameters, it will display a list of possible keys and their description.
# 2. The --all key displays the IP addresses (and symbolic names) of all hosts in the current subnet
# 3. The --target key displays a list of open system TCP ports.
# The code that performs the functionality of each of the subtasks must be placed in a separate function
# For using use this script Nmap must be installed

# set parameters:

myIP=$(ip route get 8.8.8.8 | cut -d" " -f7)
myNetmask=$(ifconfig | grep $myIP | awk '{print $4}')
myNetPrefix=$(ip addr show | grep $myIP | awk '{print $2}' | cut -d"/" -f2)

# functions:

function info {
    echo $'\n'"Source IP detected: $myIP"
    echo "Netmask: $myNetmask"
    echo "Prefix: $myNetPrefix"$'\n'
}

function all {
    info
    nmap -sP $myIP/$myNetPrefix
}

function target {
    info
    nmap -sT $myIP/$myNetPrefix
}

# main:

case "$1" in
    "--all" )
        all
    ;;
    "--target" )
        target
    ;;
    * )
        echo "You must use script only with \"--all\" or \"--target\" keys!"
    ;;
esac


