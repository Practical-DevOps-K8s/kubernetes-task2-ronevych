FROM ruby:3.3.1

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
RUN SECRET_KEY_BASE=dummy bundle exec rake assets:precompile

EXPOSE 3000
ENTRYPOINT ["bin/docker-entrypoint"]
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
