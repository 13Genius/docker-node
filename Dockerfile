FROM node

MAINTAINER Marcos Sanz <marcos.sanz@13genius.com>

ENV NODE_ENV production
ENV APP_PORT 5000
ENV GIT_URL ''

RUN apt-get -y update
RUN apt-get -y upgrade

ADD start.sh /start.sh
RUN chmod +x /start.sh

RUN npm install -g pm2
RUN npm install -g bower
RUN npm install -g grunt-cli

# Make ssh dir
RUN mkdir /root/.ssh/
RUN ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa
RUN /bin/chown -R root:root /root/.ssh
RUN /bin/chmod 0400 /root/.ssh/id_rsa
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts

EXPOSE $APP_PORT
CMD ["/start.sh"]
