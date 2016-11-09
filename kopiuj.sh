#!/bin/sh

HELP="UŻYCIE:\n\tkopiuj DESTINATION SOURCE...\nOPIS:\n\tKopiuje pliki oraz foldery (SOURCE) do DEST, na końcu każdego argumentu (SOURCE) plikowego dodaje suffix .userName, każdy argument będący folderem pakuje do archiwum .tar, dodając do niego suffix .userName.tar"

if [ "$#" -lt 2 ]
then
    echo "${HELP}"
    echo "Błąd - zbyt mała liczba argumentów!"
    exit 1
fi

if [ -e "$1" -a -f "$1" ]
then
    echo "${HELP}"
    echo "Błąd - pierwszy argument nie może być plikiem!"
    exit 1
elif ! [ -e "$1" ]
then
    mkdir $1
    if [ "$?" -ne 0 ]
    then
	echo "Nastąpił błąd przy tworzeniu folderu. Sprawdź swoje uprawnienia."
	exit 1
    fi 
fi

DEST="$1"
TAR_EXT=".tar"
FILE_SUFFIX=".${USER}"
TAR_DIR_SUFFIX=".${USER}${TAR_EXT}"

for var in "$@"
do
    if [ -d "${var}" -a "${var}" != "${DEST}" ]
    then
        tar -czvf ${var}${TAR_DIR_SUFFIX} ${var}
        cp -r ${var}${TAR_DIR_SUFFIX} ${DEST}/${var}${TAR_DIR_SUFFIX}
	rm ${var}${TAR_DIR_SUFFIX}
    elif [ -f "${var}" ]
    then
	cp ${var} ${DEST}
	mv ${DEST}/${var} ${DEST}/${var}${FILE_SUFFIX}
    else
	[ "${var}" != "${DEST}" ] && echo "${var} is invalid"
    fi
done
exit 0
