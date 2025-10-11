  GNU nano 6.2                                                              Dockerfile                                                                        
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 80

CMD [ "npm", "run", "dev"]


