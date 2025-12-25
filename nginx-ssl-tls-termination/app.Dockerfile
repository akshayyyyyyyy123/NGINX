# pull nodejs alpine based image
FROM node:alpine

# set the working directory
WORKDIR /app

# copy backend application code
COPY backend/ .

# install dependencies
RUN npm init -y && npm install express

# start the backend server
CMD ["node", "app.js"]