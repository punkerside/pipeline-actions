ARG IMAGE
FROM ${IMAGE}

RUN apk update && apk upgrade && apk add --no-cache \
  npm

CMD ["npm", "install"]