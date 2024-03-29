#!/bin/bash
#             _   _     _      _         
#  __ _  ___ | |_| |__ | | ___| |_ _   _ 
# / _` |/ _ \| __| '_ \| |/ _ \ __| | | |
#| (_| | (_) | |_| |_) | |  __/ |_| |_| |
# \__, |\___/ \__|_.__/|_|\___|\__|\__,_|
# |___/                                  
#       http://www.youtube.com/user/gotbletu
#       https://twitter.com/gotbletu
#       https://plus.google.com/+gotbletu
#       https://github.com/gotbletu
#       gotbleu@gmail.com

# by: Rhomboid
# http://www.reddit.com/r/commandline/comments/18yp5b/bash_script_to_update_multiple_blocklists/c8j6v5a

# Edit by: gotbletu
# tutorial video: https://www.youtube.com/watch?v=TyDX50_dC0M
# Transmission does not allow multiple blocklist by default or is not simple.
# This script merges multiple blocklist into one file.
# Be sure to restart your bt client/daemon to use the new iplist.
# Make sure to enable the blocklist and keep the url empty in your config file.

# Example:
# vim ~/.config/transmission-daemon/settings.json
#     "blocklist-enabled": true,
#     "blocklist-url": "",

# Do P2P Blocklists Keep You Safe?
# http://torrentfreak.com/do-p2p-blocklists-keep-you-safe/
# TLDR: 75-80% safe; not 100% fullproof

# Some suggested blocklist:
# http://www.iblocklist.com/lists.php

# Bluetack list
# level1		# General default list.
# level2		# Labs or researchers.
# level3		# The paranoids list.
# bt_bogon		# Unallocated addresses.
# bt_dshield		# known hackers
# bt_hijacked		# spammers
# bt_microsoft		# bill gates
# bt_templist		# Suspected bad peers.
# bt_spyware		# Suspected spy/malware.

# TBG list
# ijfqtofzixtwayqovmxn	# primary threat; anti p2p company
# ecqbsykllnadihkdirsh	# General Corporate Ranges
# ewqglwibdgjttwttrinl	# Bogon by TBG; Unallocated addresses
# tbnuqfclfkemqivekikv	# Hijacked by TBG; spammers
## jcjfaxgyyshvdbceroxf	# Business ISPs


set -e

# blocklist to download from
URLS=(
http://list.iblocklist.com/?list=bt_level1
http://list.iblocklist.com/?list=bt_level2
http://list.iblocklist.com/?list=bt_level3
http://list.iblocklist.com/?list=bt_bogon
http://list.iblocklist.com/?list=bt_dshield
http://list.iblocklist.com/?list=bt_hijacked
http://list.iblocklist.com/?list=bt_microsoft
http://list.iblocklist.com/?list=bt_templist
http://list.iblocklist.com/?list=bt_spyware
http://list.iblocklist.com/?list=ijfqtofzixtwayqovmxn
http://list.iblocklist.com/?list=ecqbsykllnadihkdirsh
http://list.iblocklist.com/?list=tbnuqfclfkemqivekikv
http://list.iblocklist.com/?list=ewqglwibdgjttwttrinl
)

# blocklist directory
DIR="$HOME/.config/transmission-daemon/blocklists"

# remove old blocklist
rm -f $DIR/extras*

# download new blocklist
wget "${URLS[@]}" -O - | gunzip | LC_ALL=C sort -u > "$DIR/extras-$(date +%d-%b-%R).txt"

