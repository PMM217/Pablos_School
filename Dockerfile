FROM ruby:3.2.4
# This sets the base image to Ruby 3.2.4.

RUN apt-get update -yqq
RUN apt-get install -yqq --no-install-recommends nodejs
# This updates the package lists and installs Node.js, which is required for Rails asset compilation.

COPY . /usr/src/app/
# This copies the application code into the Docker image.

ARG SECRET_KEY_BASE
# This declares an build-time argument for the Rails secret key base.

WORKDIR /usr/src/app
# This sets the working directory for subsequent commands.

ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=${SECRET_KEY_BASE}
# This sets environment variables for Rails production mode and the secret key base.

RUN gem install bundler:2.2.3
RUN bundle install
# This installs a specific version of Bundler and then installs the project dependencies.

RUN rake db:migrate
RUN rails assets:precompile
# This runs database migrations and precompiles Rails assets.

CMD [ "rails", "server"]
# This specifies the command to run when the container starts, which launches the Rails server.























