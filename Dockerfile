# Set the base image
FROM node:latest

# File Author / Maintainer
MAINTAINER Marcos Sanz <marcos.sanz@13genius.com>

# Environment
ENV NODE_ENV production
ENV APP_PORT 9000

RUN apt-get -y update
RUN apt-get -y upgrade

# Install git
RUN apt-get -y install git

# Install pm2 and gulp
RUN npm install -g gulp
RUN npm install -g pm2

# Define working directory
RUN mkdir -p /var/app/src
RUN mkdir -p ~/.ssh/

# Share logs volume
VOLUME /var/app/logs

# Expose port
EXPOSE  $APP_PORT

# Run app
ADD run.sh /run.sh
ADD run.sh /start.sh
RUN chmod +x /run.sh
RUN chmod +x /start.sh
CMD ["/run.sh"]
