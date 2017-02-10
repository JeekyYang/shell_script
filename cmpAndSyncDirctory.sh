#!/bin/bash

# Description: compare the source directory and target, 
# copy all directories and files which exist in source but not target to target directory
set -e
set -x

SourceDir=~/Desktop/source
TargetDir=~/Desktop/target

echo $SourceDir
echo $TargetDir

dirr -qr $SourceDir $TargetDir | grep -v "target" | while read line
do
	echo "line: $line"
	# get the path suffix
	param1=`echo "$line" | awk -F : {'print $1'} | awk {'print $3'}`
	param2=`echo "$line" | awk -F : {'print $2'} | awk {'print $1'}`
	echo "param1: $param1"
	echo "param2: $param2"
	delta=`echo ${param1:${#SourceDir}}`
	path="$param1/$param2"
	targetPath=$TargetDir/$delta
	if [ -d $path ]; then
		echo "this is a directory"
		cp -r $path $targetPath
	elif [ -f $path ]; then
		echo "this is a file"
		cp $path $targetPath
	else
		echo "Error"
		exit 101
	fi
done
