#!/bin/sh
# install build script for Phosphene

usage() {
	echo "Usage $0 [-r (as root)]"
	exit 1
}

dir_empty() {
	local dir=$1
	local items=( "gtk-3.0" "metacity-1" "gnome-shell" )
	for f in $items; do
		if [ -e $dir/$f ]; then return 1; fi
	done
	return -1
}

install_as_root() {
	local install_dir="/usr/share/themes/Phosphene"
	
	if [ $UID -ne 0 ]; then
		echo "You must be root to install to $install_dir"
		exit 1
	fi

	
}

while getopts ":r" opt; do
	case $opt in
		r)	install_as_root ;;
		\?)	echo "invalid option -$OPTARG" ;;
	esac
done
