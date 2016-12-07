#!/bin/bash

link_file() {
	SOURCE_FILE=/Users/zhouzhiqiang/dotfiles/$1
	DESTINATION_FILE=/Users/zhouzhiqiang/$2
	if [ -h $DESTINATION_FILE ] ; then
		echo -n "remove symbolic link: "
		rm -v $DESTINATION_FILE
	elif [ -e $DESTINATION_FILE ]; then
		echo -n "backup $DESTINATION_FILE: "
		mv -v $DESTINATION_FILE $DESTINATION_FILE.bak
	fi

	echo -n "link file: "
	ln -sv $SOURCE_FILE $DESTINATION_FILE
}

link_file tmux.conf .tmux.conf 
link_file zshrc .zshrc
link_file vimrc .vimrc
