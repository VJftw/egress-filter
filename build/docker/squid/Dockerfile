FROM alpine:3.14

RUN apk add --update --no-cache \
    squid \
    openssl

ADD root /

RUN chmod +x /docker-entrypoint.sh && \
    mkdir -p /run/squid /etc/squid/ssl \
    && chown -R squid:squid /run/squid /etc/squid \
    && chown squid:squid /etc/squid/squid.conf \
    && echo 'pid_filename /var/run/squid/squid.pid' >> /etc/squid/squid.conf

USER squid

COPY squid-configurer /squid-configurer

ENTRYPOINT [ "/docker-entrypoint.sh" ]
