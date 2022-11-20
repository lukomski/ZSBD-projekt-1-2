#!/bin/bash

if [[ $# -eq 0 ]]; then
    echo 'Need parameter with path to PSQL database dump'
    exit 1
fi

dump_file="$1"
outputfile=psql_schema.sql
echo $dump_file
cat $dump_file | awk 'RS="";/CREATE TABLE[^;]*;/' > $outputfile
cat $dump_file | awk 'RS="";/INSERT INTO .* VALUES[^;]*;/' >> $outputfile
cat $dump_file | awk 'RS="";/ALTER TABLE ONLY .* PRIMARY KEY[^;]*;/' >> $outputfile
cat $dump_file | awk 'RS="";/ALTER TABLE ONLY .* FOREIGN KEY[^;]*;/' >> $outputfile
sed -i 's/public\.//' $outputfile;
sed -i 's/ONLY //' $outputfile;

echo 'Go to "https://www.sqlines.com/online" and paste there "'$outputfile'" file.'

# cat $dump_file | awk 'RS="";/COPY .* FROM stdin;/' >> $outputfile
# sed -i "s/'//" $outputfile;
