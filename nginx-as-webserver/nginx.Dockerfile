# pull the nginx alpine base image
FROM nginx:alpine

# remove the default nginx log files as they base image has default symlink which directs the output logs to /dev/stdout and /dev/stderr
RUN rm -f /var/log/nginx/*.log && \
    mkdir -p /var/log/nginx && \
    touch /var/log/nginx/access.log && \
    touch /var/log/nginx/error.log

# copy the application code to nginx html directory
COPY site/ /usr/share/nginx/html/

# copy the custom nginx conf file to the nginx conf directory
COPY nginx.conf /etc/nginx/nginx.conf

# expose port 80 for the documentation of the service
EXPOSE 80

# start nginx in foreground mode
CMD ["nginx", "-g", "daemon off;"]