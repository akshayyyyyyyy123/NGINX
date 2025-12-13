FROM node:alpine

ARG APP_PATH
WORKDIR /app

# copy backend application code
COPY ${APP_PATH}/ .

# install dependencies
RUN npm init -y && npm install express

# start the backend server
CMD ["node", "server.js"]
