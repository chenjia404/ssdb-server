FROM centos:7
MAINTAINER wendal "chenjiablog@gmail.com"

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive


RUN yum install -y wget unzip && \
  wget --no-check-certificate https://github.com/ideawu/ssdb/archive/master.zip && \
  unzip master && \
  cd ssdb-master && \
  make && \
  make install && \
  cp /usr/local/ssdb/ssdb.conf /etc && cd .. && yes | rm -r ssdb

RUN mkdir -p /var/lib/ssdb && \
  sed \
    -e 's@home.*@home /var/lib@' \
    -e 's/loglevel.*/loglevel info/' \
    -e 's@work_dir = .*@work_dir = /var/lib/ssdb@' \
    -e 's@pidfile = .*@pidfile = /run/ssdb.pid@' \
    -e 's@level:.*@level: info@' \
    -e 's@ip:.*@ip: 0.0.0.0@' \
    -i /etc/ssdb.conf


ENV TZ Asia/Shanghai
EXPOSE 8888
ENTRYPOINT /usr/local/ssdb/ssdb-server /etc/ssdb.conf