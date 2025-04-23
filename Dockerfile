FROM nginx:alpine

WORKDIR /app

COPY . .

RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community hugo

RUN hugo --minify

RUN cp -r public/. /usr/share/nginx/html
