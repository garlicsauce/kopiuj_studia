#!/bin/sh

HELP="UŻYCIE:\n\tkopiuj DESTINATION SOURCE...\nOPIS:\n\tKopiuje pliki oraz foldery (SOURCE) do DEST, na końcu każdego argumentu (SOURCE) plikowego dodaje suffix .userName, każdy argument będący folderem pakuje do archiwum .tar, dodając do niego suffix .userName.tar"

if [ "$#" -lt 2 ]
then
	echo $HELP
	echo "Błąd - zbyt mała liczba argumentów!"
	exit 1
fi

if ! [ -d "$1" ]
then
	echo $HELP
	echo "Błąd - pierwszy argument musi być folderem!"
	exit 1
fi

DEST="$1"

for var in "$@"
do
	if [ -d "$var" ]
	then
		echo "$var is a directory"
	elif [ -f "$var" ]
	then
		echo "$var is a file"
		echo "$var will be copied to $DEST"
		cp $var $DEST
	else
		echo "$var is invalid"
	fi
done
