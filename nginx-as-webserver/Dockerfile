# Pull the lightweight alpine nginx image
FROM nginx:alpine

# copy the nginx-as-webserver directory to the nginx html directory
COPY site/* /usr/share/nginx/html/

# expose the port 80 for the documentation of the service
EXPOSE 80

# start nginx
CMD ["nginx", "-g", "daemon off;"]