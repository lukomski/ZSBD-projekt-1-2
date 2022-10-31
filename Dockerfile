FROM postgres:15.0
COPY 00_init.sql /docker-entrypoint-initdb.d/
COPY 01_articles_init.sql /docker-entrypoint-initdb.d/