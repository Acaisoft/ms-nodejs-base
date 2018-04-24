FROM node:carbon

WORKDIR /usr/src/app

ADD package*.json ./

RUN yarn install --production=true

ADD . .

EXPOSE 8080
CMD [ "yarn", "start" ]
