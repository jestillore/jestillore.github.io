FROM nginx:alpine

WORKDIR /usr/share/nginx/html

RUN doas apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community /usr/local/bin/hugo

COPY . .
