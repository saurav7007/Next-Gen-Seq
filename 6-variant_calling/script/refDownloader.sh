#! /bin/bash

mkdir ../ref
cd ../ref

while read url; do
	wget "$url"
done < ../script/refURLs.txt

f=$(ls *.gz)
gzip -d ${f}
