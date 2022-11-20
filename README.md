## See docs/sprawozdanie-projekt-2.pdf file

## Run database

```
docker-compose up --build
```

### connect to dockerized database

```
docker exec -it vrl_psql psql vrl postgres
```

### list databases

```
\l
```

### list tables

```
\dt
```

### Show details about table

```
\d packageTypesPackages
```

### Usefull commands

```
\timing
\pset pager off
```

### Open sqlcmd

```
docker exec -it vrl_mssql /opt/mssql-tools/bin/sqlcmd -U sa -P 3ywhNTJ0oK?DXto
```

### sqlcmd

#### Show databases

```
select name from sys.databases
go
```

#### Create database

```
create database vrl
docker exec -it vrl_mssql /opt/mssql-tools/bin/sqlcmd -U sa -P 3ywhNTJ0oK?DXto -Q "create database vrl"
docker exec -it vrl_mssql /opt/mssql-tools/bin/sqlcmd -U sa -P 3ywhNTJ0oK?DXto -Q "drop database vrl"
```

#### Seelct database

```
use vrl
```

#### Show tables

```
docker exec -it vrl_mssql /opt/mssql-tools/bin/sqlcmd -U sa -P 3ywhNTJ0oK?DXto -d vrl -Q "select Distinct table_name FROM information_schema.tables"
```

#### Import dump

```
docker exec -it vrl_mssql /opt/mssql-tools/bin/sqlcmd -U sa -P 3ywhNTJ0oK?DXto -d vrl -i /hostFiles/mssqlsimpledump.sql
```

#### start cloudbeaver

```
sudo docker run --name cloudbeaver --rm -ti -p 8080:8978 -v /var/cloudbeaver/workspace:/opt/cloudbeaver/workspace dbeaver/cloudbeaver:latest
```

go to http://localhost:8080
