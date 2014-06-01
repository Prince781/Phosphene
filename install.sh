#!/bin/sh
# install build script for Phosphene

folders=( "gtk-3.0" "metacity-1" "gnome-shell" )

usage() {
	echo "Usage $0 [-r (as root)]"
	exit 1
}

check_for_root() {
	if [ $UID -ne 0 ]; then
		echo "You must be root to install to $1"
		exit 1
	fi
}

dir_empty() {
	local dir=$1
	local is_empty=true
	for f in ${folders[@]}; do
		if [ -d $dir/$f ]; then
			is_empty=false
			break
		fi
	done
	echo $is_empty
}

install_theme() {
	local install_dir=$1
	if [ $(dir_empty $install_dir) = false ]; then
		printf "Overwrite ${install_dir}? (y/n): "
		read overwrite
		if [ $overwrite = "n" ]; then
			echo "Quitting."
			exit 1
		fi
	fi
	
	if [ ! -d $install_dir ]; then mkdir -p $install_dir; fi

	for f in ${folders[@]}; do
		cp -rf $f $install_dir/$f
	done

	echo "Successfully installed to $install_dir"
}

install_as_root() {
	local dir="/usr/share/themes/Phosphene"
	
	check_for_root $dir

	install_theme $dir
}

while getopts ":riu" opt; do
	case $opt in
		r)	install_as_root ;;
		i)	install_theme "$HOME/.local/share/themes/Phosphene" ;;
		u)
			echo "Removing Phosphene from home directory."
			rm -rf $HOME/.local/share/themes/Phosphene
			;;
		\?)	echo "invalid option -$OPTARG" ;;
	esac
done
