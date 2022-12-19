FROM node:19-alpine

WORKDIR /app

COPY . .

ARG APPID

RUN npm install

EXPOSE 9000

CMD ["npm", "run", "dev"]
