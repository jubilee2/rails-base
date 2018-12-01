FROM ruby:2.5.1-alpine

RUN apk --no-cache add nodejs postgresql-client tzdata && \
  apk add --no-cache --virtual build-deps build-base postgresql-dev && \
  mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
RUN bundle install --without development test && \
  apk del build-deps
