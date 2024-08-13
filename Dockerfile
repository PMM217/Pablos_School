# Use a base image

FROM ruby:3.2.4
 
# Set the working directory in the container

WORKDIR /app
 
# Copy the current directory contents into the container at /app

COPY . .
 
# Install any needed packages specified in the Gemfile

RUN bundle install
 
# Make port 80 available to the world outside this container

EXPOSE 80
 
# Define environment variable

ENV NAME World
 
# Run app.py when the container launches

CMD ["rails", "server", "-b", "0.0.0.0"]

