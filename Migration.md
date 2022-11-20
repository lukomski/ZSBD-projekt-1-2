# Make migration

## 1. Get dump of PSQL database

## 2. Extract needed parts from dump

```
bash scripts/get_schema.bash psql_dump.sql
```

## 3. Get psql_schema.sql file and paste in https://www.sqlines.com/online page. Set migration from psql -> Microsoft SQL Server

## 4. Save result of converting operation to mssql_shema.sql in /volumes/mssql/mssql_schema.sql

```
sudo gedit volumes/mssql/mssql_schema.sql
```

## 5. Drop (if exists) and create database vrl

```
docker exec -it vrl_mssql /opt/mssql-tools/bin/sqlcmd -U sa -P 3ywhNTJ0oK?DXto -Q "drop database vrl"
docker exec -it vrl_mssql /opt/mssql-tools/bin/sqlcmd -U sa -P 3ywhNTJ0oK?DXto -Q "create database vrl"
```

## 6. Load schema from file

```
docker exec -it vrl_mssql /opt/mssql-tools/bin/sqlcmd -U sa -P 3ywhNTJ0oK?DXto -d vrl -i /host_files/mssql_schema.sql
```

## 7. See tables to be sure everything went well

```
docker exec -it vrl_mssql /opt/mssql-tools/bin/sqlcmd -U sa -P 3ywhNTJ0oK?DXto -d vrl -Q "select Distinct table_name FROM information_schema.tables"
```

## 8. Open sqlcmd

```
docker exec -it vrl_mssql /opt/mssql-tools/bin/sqlcmd -U sa -P 3ywhNTJ0oK?DXto -d vrl
```
