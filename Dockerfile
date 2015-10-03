FROM ubuntu
MAINTAINER wendal "wendal1985@gmail.com"

RUN apt-get update && \
  apt-get install -y --force-yes git make gcc g++ && apt-get clean && \
  git clone --depth 1 https://github.com/ideawu/ssdb.git ssdb && \
  cd ssdb && make && make install && cp ssdb-server /usr/bin && \
  apt-get remove -y --force-yes git make gcc g++ && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  cd .. && yes | rm -r ssdb

ENV TZ Asia/Shanghai
EXPOSE 8888
#ENTRYPOINT /usr/bin/ssdb-server /var/lib/ssdb/ssdb.conf