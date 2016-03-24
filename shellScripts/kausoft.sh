#!/bin/bash


# xxxxxxxxxxx


ks(){
	_reload


	if [ "$1" == "-l" ]
	then 
	
		case "$2" in
			debug )		
			echo "debug"
			;;
		* )
			echo "*"
		;;
		esac
	
		export loglevel=1
		shift
	else
		export loglevel=0
	fi

	

	
	case "$1" in
		c ) 
			echo "ks_config 1"
			_config
			export param2=$2
			
						echo "config 3  $1 $2  "
			echo $1
		;;
		
	l ) 
			echo "Set Loglevel"
		;;	
	kausoft ) 
	      echo "kausoft"
	      source $KAUSOFT/kausoft.sh
        ;;
	add ) 
		shift
		for dir in "$@"
		do
			dir=${dir%%/}
			if [ -d "$dir/.git" ]; then
				echo "$dir" >> .mplist
				cat .mplist | sort -u > .mplist
			fi			
		done
		;;
	all )	
		shift
		for dir in ./*/
		do
			dir=${dir%%/}
			if [ -d "$dir/.git" ]; then
				pushd "$dir" > /dev/null
				if [ "$loglevel" == "0" ]; then echo -e "${COL_YELLOW}$dir... $COL_NONE"; fi
				"$@"
				if [ "$loglevel" == "0" ]; then echo -e "${COL_YELLOW}completed\n $COL_NONE"; fi 
				popd > /dev/null
			fi			
		done
		;;
	ls )
		shift
		echo "$(cat .mplist | wc -w) projects:" 
		cat .mplist
		;;
	pom )
		shift
		head -$(awk '/modules/{ print NR; exit }' pom.xml) pom.xml > pom.new
		for dir in $(cat .mplist)
		do
			echo "    <module>$dir</module>" >> pom.new
		done
		tail -$(($(wc -l pom.xml |cut -d' ' -f1)-$(awk '/\/modules/{ print NR; exit }' pom.xml)+1)) pom.xml >> pom.new
		echo -e "${COL_YELLOW}"
		cat pom.new
		echo -e "${COL_NONE}"
		read -p "Replace pom.xml with this content (y/n)?" yn
		case $yn in
			[Yy]* ) mv pom.new pom.xml
			;;
			* ) echo "pom.xml untouched, aforementioned content in pom.new"
			;;
		esac
		;;
	rm )
		shift
		for dir in "$@"
		do
			dir=${dir%%/}
			if [ -d "$dir/.git" ]; then
				cat .mplist | grep -v "$dir" > .mplist
			fi			
		done
		;;

	* )	
		for dir in $(cat .mplist)
		do
			pushd "$dir" > /dev/null
			if [ "$loglevel" == "0" ]; then echo -e "${COL_YELLOW}$dir... $COL_NONE"; fi
			"$@"
			if [ "$loglevel" == "0" ]; then echo -e "${COL_YELLOW}completed\n $COL_NONE"; fi
			popd > /dev/null
		done
		;;
	esac
}

# -------------------------------------------------------

_config() {
			echo "config 72  $1 "
			echo "param2= $param2"
}

_reload(){
	source $KAUSOFT/kausoft.sh
	export message="reloadet "
#	_log	
}

_log() {
	if [ "$loglevel" == "0" ]; then echo -e "l-$loglevel ${COL_YELLOW}$message\n $COL_NONE"; fi
}



