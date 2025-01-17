FROM ubuntu:14.04
MAINTAINER Wayne Connolly <wayne@wayneconnolly.com>

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
    echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list && \
    apt-get update && \
    apt-get install -y --force-yes pwgen mongodb-org mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools && \
    echo "mongodb-org hold" | dpkg --set-selections && echo "mongodb-org-server hold" | dpkg --set-selections && \
    echo "mongodb-org-shell hold" | dpkg --set-selections && \
    echo "mongodb-org-mongos hold" | dpkg --set-selections && \
    echo "mongodb-org-tools hold" | dpkg --set-selections

VOLUME /data/db

ENV AUTH no
ENV STORAGE_ENGINE mmapv1
ENV JOURNALING yes
ENV DIR_PER_DB yes

ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh
RUN chmod +x /run.sh
RUN chmod +x /set_mongodb_password.sh

EXPOSE 27017 28017

CMD ["/run.sh"]
