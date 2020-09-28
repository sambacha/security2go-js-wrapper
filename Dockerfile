
FROM debian:buster-slim
ARG $VCS

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends libpcsclite1 libpcsclite-dev install gnupg software-properties-common locales curl gcc g++ make && \
    locale-gen en_US.UTF-8 && \
    apt-get -qq update && \
    apt-get -qq -y dist-upgrade && \
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - && \
    sudo apt-get install -y nodejs && \
    apt-get -qq -y purge gnupg software-properties-common curl && \
    apt -y autoremove \
    apt update \
    mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

# app source
COPY . .


EXPOSE 8080

CMD [ "node", "server.js" ]
