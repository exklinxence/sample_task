FROM node:20.11.1-slim

WORKDIR /src

ENV MONGODB_URI=

COPY package.json app.js /src/

RUN npm install 

CMD [ "node", "app.js" ]
