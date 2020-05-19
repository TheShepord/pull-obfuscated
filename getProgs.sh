#!/bin/bash

link="https://www.ioccc.org"
filein=$(mktemp)
fileout=$(mktemp)
i=1

if [ "$1" == "" ]; then
  DIRECTORY="./"
else
  DIRECTORY="$1"
fi

wget -q -O $filein $link/years.html
egrep -o "[0-9]{4}\/.*\/prog.c" $filein > $fileout

if [ ! -d "$DIRECTORY" ]; then
  mkdir $DIRECTORY
fi

while read p; do
  wget  -O ./$DIRECTORY/t$i.c "$link/$p"
  chmod 666 ./$DIRECTORY/t$i.c
  i=$(( i + 1 ))
done < $fileout


rm $filein
rm $fileout
