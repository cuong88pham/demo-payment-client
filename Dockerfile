# Setup ruby
FROM ruby:2.6.3

RUN apt-get update -qq --fix-missing \
  && apt-get install -y --no-install-recommends build-essential libv8-dev nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set ENV
ARG RAILS_ENV
ENV RAILS_ENV ${RAILS_ENV:-production}

RUN mkdir -p /app
WORKDIR /app

# Needed for ExecJS
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Libre libreoffice
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:libreoffice/ppa
RUN apt-get install -y --no-install-recommends libreoffice-writer

RUN soffice --version

# Install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5 --without test

# Copy the main application.
COPY . ./

# Start server
EXPOSE 5000
CMD ["bundle", "exec", "puma", "-p", "5000"]
