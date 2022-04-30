FROM alpine:3.15.4

RUN apk update && apk upgrade && apk add --no-cache \
  npm \
  bash

RUN npm install snyk -g

WORKDIR /app
ENTRYPOINT ["snyk"]