FROM ruby:3.2.4
 
RUN apt-get update -yqq
RUN apt-get install -yqq --no-install-recommends nodejs
 
COPY . /usr/src/app/
ARG SECRET_KEY_BASE
 
WORKDIR /usr/src/app
ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=${SECRET_KEY_BASE}
RUN gem install bundler:2.2.3
RUN bundle install
RUN rake db:migrate
RUN rails assets:precompile
CMD [ "rails", "server"]

























# # Use a base image
# FROM ruby:3.2.4
 
# # Set the working directory in the container
# WORKDIR /app
 
# # Copy the Gemfile and Gemfile.lock
# COPY Gemfile* ./
 
# # Install any needed packages specified in the Gemfile
# RUN bundle install
 
# # Copy the rest of the application code
# COPY . .
 
# # Precompile assets (if necessary)
# RUN bundle exec rake assets:precompile
 
# # Make port 3000 available to the world outside this container
# EXPOSE 3000
 
# # Run the web server
# CMD ["rails", "server", "-b", "0.0.0.0"]

