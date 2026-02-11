FROM ruby:3.3.1-alpine

RUN apk add --no-cache nodejs postgresql-client build-base postgresql-dev tzdata
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --without development test
COPY . .
RUN SECRET_KEY_BASE=dummy RAILS_ENV=production bundle exec rake assets:precompile

EXPOSE 3000
ENTRYPOINT ["bin/docker-entrypoint"]
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
