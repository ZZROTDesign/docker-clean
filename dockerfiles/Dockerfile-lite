FROM alpine:latest

RUN apk add --no-cache bash

COPY . /docker-clean

ENTRYPOINT ["/docker-clean/docker-clean"]
