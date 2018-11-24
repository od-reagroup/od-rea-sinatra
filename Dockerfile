FROM ruby:2.5-alpine
WORKDIR /app
COPY code/Gemfile /app/
RUN bundle install
COPY code/* /app/
EXPOSE 80
ENTRYPOINT ["bundle", "exec", "rackup", "-o", "0.0.0.0", "-p", "80"]
