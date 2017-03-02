#!/bin/bash


# xxxxxxxxxxx


# Info für cygwin
# see C:\Users\B026670 -->  .bash_history .bashrc  .aliases
# 

kshelp(){

    case "$1" in

	

	* )	
echo "help"
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
ks(){
	_reload   
	
	case "$1" in 	
	cdws 	) _cdws $2 ;;
	b 		) _build $2 $3 ;;
	build 	) _build $2 $3 ;;
	help    ) _help $2 ;;
	


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
	_help $2
#		for dir in $(cat .mplist)
#		do
	#		pushd "$dir" > /dev/null
	#	if [ "$loglevel" == "0" ]; then echo -e "${COL_YELLOW}$dir... $COL_NONE"; fi
	#		"$@"
	#		if [ "$loglevel" == "0" ]; then echo -e "${COL_YELLOW}completed\n $COL_NONE"; fi
	#		popd > /dev/null
	#	done
		;;
	esac
}

# ------------------------------------------------------- Aktualisieren von diesem Script.
_reload(){
	source $KAUSOFT/kausoft.sh
	#export message="reloadet "
}

_log() {
	if [ "$loglevel" == "0" ]; then echo -e "l-$loglevel ${COL_YELLOW}$message\n $COL_NONE"; fi
}


_cdws() { 
    #echo "Set Workspace "$1		

	case "$1" in	
		master )
			export NEWBLD_SPACE=$CDRIVE/Data/GitRepos/wsBLDMaster
			export ORACLE_HOME=$CDRIVE/Dev/WLS12.1.1		
			cd  /cygdrive/c/Data/GitRepos/wsBLDMaster > /dev/null		
		;;

		neon1 )
			export NEWBLD_SPACE=$CDRIVE/Data/GitRepos/BLD_ws_neon_1
			export ORACLE_HOME=$CDRIVE/Dev/WLS12.1.1		
            cd  /cygdrive/c/Data/GitRepos/BLD_ws_neon_1 > /dev/null					
		;;
		
	    * )				
			echo "" 
			echo "Help:" 
			echo "ks cdws master = setzen Workspace und Git-Repo auf wsBLDMaster "
			echo "ks cdws neon1  = setzen Workspace und Git-Repo auf BLD_ws_neon_1 "
		;;
	esac
	
	echo "" 
	echo "Feedback:ks cdws "$1
	echo "NEWBLD_SPACE = " $NEWBLD_SPACE
	echo "ORACLE_HOME  = " $ORACLE_HOME
	echo "-------------------------------------------------"
}



_build() {
    export BUILD_TEST=-DskipTests
	if [ "$2" == "-t" ]; then export BUILD_TEST=""; fi	
	case "$1" in	
	
		pws )
			cd $NEWBLD_SPACE/prevoWebService
			git branch 
			mvn clean install $BUILD_TEST
		;;

    	pal )
			cd $NEWBLD_SPACE/prevoAccessLayer
			git branch 
			mvn clean install $BUILD_TEST
		;;

		wsa )
			cd $NEWBLD_SPACE/webServiceAccess
			git branch 
			mvn clean install $BUILD_TEST
		;;

		I )
			cd $NEWBLD_SPACE/impadok
			git branch 
			mvn clean install $BUILD_TEST
		;;

		z )
			cd $NEWBLD_SPACE/zie2klService
			git branch 
			mvn clean install $BUILD_TEST
		;;

		g )
			cd $NEWBLD_SPACE/gwtBase
			git branch 
			mvn clean install $BUILD_TEST
		;;

		m )
			cd $NEWBLD_SPACE/myKLBVG
			git branch 
			mvn clean install $BUILD_TEST
		;;

		n )
			cd $NEWBLD_SPACE/NewBLD
			git branch 
			mvn clean install $BUILD_TEST
		;;
		
		g+ )
			cd $NEWBLD_SPACE/gwtBase
			git branch 
			mvn clean install $BUILD_TEST
			cd $NEWBLD_SPACE/myKLBVG
			git branch 
			mvn clean install $BUILD_TEST
			cd $NEWBLD_SPACE/NewBLD
			git branch 
			mvn clean install $BUILD_TEST
		;;

		m+ )
			cd $NEWBLD_SPACE/myKLBVG
			git branch 
			mvn clean install $BUILD_TEST
			cd $NEWBLD_SPACE/NewBLD
			git branch 
			mvn clean install $BUILD_TEST
		;;


		
		
		
		
	    * )				
			echo "" 
			echo "Syntax: "
            echo "b|build [MODULE] [PARAMETER]" 
			echo "" 
			echo "MODULE:" 			
			echo "pws = prevoWebService" 
			echo "pal = prevoAccessLayer" 
			echo "wsa = webServiceAccess" 
			echo "i = impaDok" 
			echo "z = zie2klService" 
			echo "g = gwtBase" 
			echo "m = myKLBVG" 
			echo "n = NewBLD"
			echo "g+ = gwtBase,myKLBVG,NewBLD" 
			echo "m+ = myKLBVG,NewBLD" 
			echo "" 
			echo "PARAMETER:" 
			echo "-t = Test ausführen "
		;;
	esac	
}


# ***********************************  help **************************************
# Funktion ks help parameter
# ***********************************  help **************************************
_help() {
    source $KAUSOFT/kausoft.sh    
	
   	case "$1" in	
	    # 
		param )	
			echo "ks- 170213-0819 --- help "$2 "-----------------------"
			# Ausgeben der gesetzten Variablen 
			echo "KAUSOFT        = "$KAUSOFT
			echo "loglevel       = "$loglevel
	
			echo "MAVEN_HOME     = "$MAVEN_HOME
			echo "JAVA_HOME      = "$JAVA_HOME
			echo "ASCIIDOC_HOME  = "$ASCIIDOC_HOME
			echo "CDRIVE         = "$CDRIVE
			echo "KLTOOLS        = "$KLTOOLS
			echo "NEWBLD_SPACE   = "$NEWBLD_SPACE
			echo "ORACLE_HOME    = "$ORACLE_HOME
		;;
	
	
	
	
		* )	
#		    echo ". . . . . . . . . "
#		    echo ""
			echo "ks help param - Auflisten der gesetzten Variablen  "			
			echo "ks cdws - Setzen der Arbeitsumgebung "			
			echo "ks b|build [MODULE] [PARAMETER] - maven Bulid  "			
			echo			
			echo "gitbranchstat"	
			echo "gitgraph"	
#		    echo "_______________________________"
			
			
			
			
	#		echo "in ycgwin werden folgende Files geladen --> .basch_profile .bashrc .profile  .aliases  --> C:\Users\B026670"
			
			
			
		;;

	esac
	
	
}




