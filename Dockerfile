FROM ruby:2.6.3-alpine

RUN apk --no-cache add nodejs mysql-client tzdata yarn && \
  mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock package.json yarn.lock /usr/src/app/
# Install build dependencies - required for gems with native dependencies
RUN apk add --no-cache --virtual build-deps mysql-dev build-base && \
  bundle install --without development test && \
  yarn install && \
  apk del build-deps
