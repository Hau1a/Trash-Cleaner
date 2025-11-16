#!bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "ERROR: The script was launched without super user rights"

else

	#clean file and folder ath the user's request
	filename="Trash.txt"

	tail -n +4 "$filename" | while read -r path; do
		if [ -n "$path" ];then
			if [ -e "$path" ]; then
				echo "Deleting: $path"
				sudo rm -rf "$path"
			else
				echo "Not exist: $path"
			fi
		fi
	done

	#clean cache

	sudo apt clean
	sudo journalctl --vacuum-time=7d
	rm -rf ~/.local/share/Thrash/*
	rm -rf ~/.cache/*
	rm -rf ~/.thumbnails/*

fi
