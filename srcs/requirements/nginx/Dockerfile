FROM alpine:3.20

WORKDIR /app

RUN apk update \
	&& apk add nginx

CMD ["nginx", "-g", "daemon off;"]
