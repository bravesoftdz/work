#!/bin/sh

if [ -z "$*" ]; then
    echo "Usage: $0 <files to convert>"
    exit -1
fi

echo 'Convert UTF-16 files to UTF-8:'
for file in "$@"
do
    file "$file" | grep 'UTF-16' >/dev/null
    if [ $? -ne 0 ]; then
        echo "Skipping '$file': not UTF-16"
        continue
    fi
    echo "Begin conversion for file '$file':"

    bak_file="${file}.bak"
    if [ -f $bak_file ]; then
        echo "Error: backup file ($bak_file) already exists."
        exit -2
    fi

    mv "$file" "$bak_file"
    if [ $? -ne 0 ]; then
        echo "Error: could not move '$file' to backup: $!"
        exit -3
    fi

    iconv -f UTF-16 -t UTF-8 "$bak_file" > "$file"
    if [ $? -ne 0 ]; then
        echo "Error: iconv failed: $!"
        exit -4
    fi

    rm -f "$bak_file"    
done
