FROM alpine:3.20

WORKDIR /app

RUN apk update \
	&& apk add nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/selfsigned.key\
	-out /etc/nginx/ssl/selfsigned.crt \
	-subj "/C=US/ST=YourState/L=YourCity/O=YourOrganization/OU=YourUnit/CN=yourdomain.com"


COPY nginx.conf /etc/nginx/nginx.conf
COPY wordpress.conf /etc/nginx/conf.d/


CMD ["nginx", "-g", "daemon off;"]
# CMD ["sleep", "infinity"]
