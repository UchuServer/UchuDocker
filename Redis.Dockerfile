FROM redis:alpine
WORKDIR /redis

COPY redis.conf /usr/local/etc/redis/redis.conf
COPY redis.sh ./

RUN chmod +x redis.sh