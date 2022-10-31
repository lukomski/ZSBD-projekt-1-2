FROM postgres:15.0
COPY initialize/* /docker-entrypoint-initdb.d/
