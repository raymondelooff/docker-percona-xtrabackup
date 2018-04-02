FROM debian:stretch

LABEL maintainer="raymondelooff"

RUN apt-get update && \
    apt-get install -y gnupg2 && \
    apt-get clean

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 9334A25F8507EFA5 && \
    echo "deb http://repo.percona.com/apt stretch main" >> /etc/apt/sources.list && \
    apt-get update

RUN apt-get update && \
    apt-get install -y percona-xtrabackup-24 && \
    apt-get clean

ENV MYSQL_SOCKET ""
ENV MYSQL_HOST ""
ENV MYSQL_PORT ""
ENV MYSQL_USER ""
ENV MYSQL_PASSWORD ""
ENV DATA_DIR /var/lib/mysql
ENV TARGET_DIR /target

VOLUME /var/lib/mysql /target

CMD xtrabackup --backup --socket=$MYSQL_SOCKET --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PASSWORD --datadir=$DATA_DIR --target-dir=$TARGET_DIR && \
    xtrabackup --prepare --target-dir=$TARGET_DIR && \
    xtrabackup --prepare --target-dir=$TARGET_DIR
