FROM ruby:2.6.3

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -qq -y build-essential nodejs yarn mariadb-client tzdata --fix-missing --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock package.json yarn.lock /app/
# Install build dependencies - required for gems with native dependencies
RUN bundle install --without development test && \
  yarn install
