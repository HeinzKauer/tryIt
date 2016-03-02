#! /bin/bash

pwd=`pwd`
relAsciiDocHome=`python -c "import os.path; print os.path.relpath('$ASCIIDOC_HOME', '$pwd')"`

for f in *.txt
do
	echo `date +%T`: initial processing $f
	python $ASCIIDOC_HOME/asciidoc.py -a asciidoc-dir=$relAsciiDocHome $@ $f
done
echo `date +%T`: now listening for changes in \*.txt files

while [ 1 ]
do 
	newest=`ls -1 -t --indicator-style=none|head -1|grep .txt$`
	if [ "$newest" != "" ]
	then
		echo `date +%T`: processing $newest
		python $ASCIIDOC_HOME/asciidoc.py -a asciidoc-dir=$relAsciiDocHome $@ $newest
	fi
	sleep .1
done
