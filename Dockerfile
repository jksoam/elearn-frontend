FROM node

WORKDIR /app

COPY . .

RUN npm install

RUN npm run build

EXPOSE 8085

CMD ["npm", "start"]
