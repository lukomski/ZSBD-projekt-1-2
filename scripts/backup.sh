#!/bin/sh

now=$(date +"%d-%m-%Y_%H-%M")
pg_dump -U postgres --inserts vrl > "/backups/vrl_dump_$now.sql"

exit 0