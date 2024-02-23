FROM node:20.11.1-slim

WORKDIR /src

ARG MONGODB_URI
ENV MONGODB_URI=$MONGODB_URI

COPY package.json app.js /src/

RUN npm install 

CMD [ "node", "app.js" ]
