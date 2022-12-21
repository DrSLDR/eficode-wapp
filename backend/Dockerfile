FROM node:19-alpine

WORKDIR /app

COPY . .
RUN npm install

ARG APPID
ENV APPID=${APPID:-null}

EXPOSE 9000

CMD ["npm", "run", "dev"]
