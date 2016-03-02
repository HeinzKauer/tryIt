#! /bin/bash

pwd=`pwd`
relAsciiDocHome=`python -c "import os.path; print os.path.relpath('$ASCIIDOC_HOME', '$pwd')"`

for f in doc/*.txt
do
	echo `date +%T`: initial processing $f
	python $ASCIIDOC_HOME/asciidoc.py -a asciidoc-dir=$relAsciiDocHome $@ $f
done
echo `date +%T`: now listening for changes in \*.txt files

