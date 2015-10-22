FROM node

MAINTAINER Marcos Sanz <marcos.sanz@13genius.com>

ENV NODE_ENV production
ENV APP_PORT 5000
ENV GIT_URL ''

ADD start.sh /start.sh
RUN chmod +x /start.sh

RUN npm install -g pm2
RUN npm install -g bower
RUN npm install -g grunt-cli

EXPOSE $APP_PORT
CMD ["/start.sh"]
