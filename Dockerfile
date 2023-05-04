FROM alpine:3

MAINTAINER unoexperto <unoexperto.support@mailnull.com>

# python is necessary for ssdb-cli
RUN apk update --no-cache && \
    apk add --virtual .build-deps gcc autoconf make g++ git

RUN mkdir -p /usr/src/ssdb

RUN git clone --depth 1 https://github.com/ideawu/ssdb.git /usr/src/ssdb && \
  make -C /usr/src/ssdb && \
  make -C /usr/src/ssdb install && \
  rm -rf /usr/src/ssdb

RUN apk del .build-deps

RUN sed \
    -e 's@ip:.*@ip: 0.0.0.0@' \
    -e 's@cache_size:.*@cache_size: 4096@' \
    -e 's@write_buffer_size:.*@write_buffer_size: 512@' \
    -e 's@level:.*@level: info@' \
    -e 's@output:.*@output:@' \
    -i /usr/local/ssdb/ssdb.conf

EXPOSE 8888
VOLUME /usr/local/ssdb/var/data
VOLUME /usr/local/ssdb/var/meta
WORKDIR /usr/local/ssdb/

CMD ["/usr/local/ssdb/ssdb-server", "/usr/local/ssdb/ssdb.conf"]