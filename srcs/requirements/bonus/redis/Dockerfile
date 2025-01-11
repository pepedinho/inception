FROM alpine:3.20

RUN apk add --update redis

RUN mkdir /data && chmod 755 /data

COPY redis.conf /etc/redis.conf

EXPOSE 6379

CMD ["redis-server", "/etc/redis.conf"]