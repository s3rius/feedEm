FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential libpq-dev apt-transport-https \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
# Install capybara-webkit deps
RUN apt-get update \
&& apt-get install -y --no-install-recommends xvfb qt5-default libqt5webkit5-dev \
gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x\
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Node.js
RUN curl -sL  https://deb.nodesource.com/setup_11.x  | bash - \
&& apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update \
&& apt-get install -y --no-install-recommends yarn \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

COPY package.json /myapp/package.json

RUN yarn install
RUN yarn upgrade
