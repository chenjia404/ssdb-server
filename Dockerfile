FROM alpine:3 as builder

MAINTAINER unoexperto <unoexperto.support@mailnull.com>

# python is necessary for ssdb-cli
RUN apk update && \
    apk add gcc  && \
    apk add --virtual .build-deps autoconf make g++ git

RUN mkdir -p /usr/src/ssdb

RUN git clone --depth 1 https://github.com/ideawu/ssdb.git /usr/src/ssdb && \
  make -j8 -C /usr/src/ssdb && \
  make -C /usr/src/ssdb install && \
  rm -rf /usr/src/ssdb

RUN apk del .build-deps

FROM alpine:3
RUN  apk add gcc 
COPY --from=builder  /usr/local/ssdb /usr/local/ssdb

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