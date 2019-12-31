FROM ruby:2.6.5-alpine

RUN apk --no-cache add nodejs mysql-dev tzdata yarn build-base

WORKDIR /app

COPY Gemfile Gemfile.lock package.json yarn.lock /app/
# Install build dependencies - required for gems with native dependencies
RUN bundle install --without development test && \
  yarn install
