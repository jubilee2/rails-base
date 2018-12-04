FROM ruby:2.5.1-alpine

RUN apk --no-cache add nodejs postgresql-client tzdata && \
  mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock /usr/src/app/
# Install build dependencies - required for gems with native dependencies
RUN apk add --no-cache --virtual build-deps build-base postgresql-dev && \
  bundle install --without development test && \
  apk del build-deps
