FROM ruby:2.5-alpine
WORKDIR /app
COPY simple-sinatra-app/Gemfile /app/
RUN bundle install
COPY simple-sinatra-app/* /app/
EXPOSE 80
ENTRYPOINT ["bundle", "exec", "rackup", "-o", "0.0.0.0", "-p", "80"]
