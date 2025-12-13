# pull the nginx alpine base image
FROM nginx:alpine

# remove the default nginx log files as they base image has default symlink which directs the output logs to /dev/stdout and /dev/stderr
RUN rm -f /var/log/nginx/*.log && \
    mkdir -p /var/log/nginx/ && \
    touch /var/log/nginx/access.log && \
    touch /var/log/nginx/error.log

# copy the custom nginx.conf file to the nginx conf directory
COPY nginx.conf /etc/nginx/nginx.conf

# copy the application code to the nginx html directory
COPY app/ /usr/share/nginx/html/

# expose port 80
EXPOSE 80

# start the nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]