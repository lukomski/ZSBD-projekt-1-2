## See sprawozdanie.pdf file

## Run database

```
docker-compose up --build
```

### connect to dockerized database

```
docker exec -it vrl_db psql vrl postgres
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
