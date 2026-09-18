FROM node:20-alpine

RUN apk update && apk upgrade --no-cache

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
