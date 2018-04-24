FROM node:carbon

WORKDIR /usr/src/app

ADD package*.json ./

RUN npm install --only=production

ADD . .

EXPOSE 8080
CMD [ "npm", "start" ]