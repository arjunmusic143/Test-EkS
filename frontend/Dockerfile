#this is user for get image from docker hub
FROM node:14.17.0-alpine 

#this is user for docker working folder
WORKDIR /app 


COPY package*.json ./


RUN npm install 

COPY . . 

EXPOSE 3000

CMD ["npm","start", "run"]
