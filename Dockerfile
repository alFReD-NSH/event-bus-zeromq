FROM node:6-alpine

ENV APP_DIR=/app

COPY package.json npm-shrinkwrap.json $APP_DIR/
RUN chown -R node:node $APP_DIR/*

WORKDIR $APP_DIR

RUN apk add --no-cache make gcc g++ python zeromq zeromq-dev \
  && npm install \
  && npm cache clean \
  && apk del make gcc g++ python zeromq-dev

USER node

ADD . $APP_DIR

EXPOSE 5556
EXPOSE 5557
EXPOSE 5558

CMD ["bin/bus"]
