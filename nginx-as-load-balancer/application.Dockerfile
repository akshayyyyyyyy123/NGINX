# Base image
FROM node:20-alpine

# set the working directory
WORKDIR /app

# accept build argument for which server to copy
ARG SERVER_NAME

# copy the backend files dynamically
COPY backend/${SERVER_NAME}/ .

# install the dependencies associated to build the application
RUN npm install express

# pass SERVER_NAME to app.js
ENV SERVER_NAME=${SERVER_NAME}

# start the app
CMD ["node", "app.js"]