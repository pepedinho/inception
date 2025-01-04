FROM alpine:3.20

WORKDIR /app

RUN apk update \
	&& apk add nginx

# Copier la configuration
COPY nginx.conf /etc/nginx/nginx.conf
COPY wordpress.conf /etc/nginx/conf.d/


CMD ["nginx", "-g", "daemon off;"]
