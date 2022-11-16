FROM postgres:15.0
COPY initialize/* /docker-entrypoint-initdb.d/
COPY ./scripts/backup.sh /scripts/
COPY ./scripts/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh 
RUN chmod uo+x /usr/local/bin/docker-entrypoint.sh 
RUN apt update
RUN apt install -y cron
RUN mkdir /backups/
RUN echo 'cron_enable="YES"' >> /etc/rc.conf
RUN echo "* * * * * root sh /scripts/backup.sh" >> /etc/crontab
RUN service cron start