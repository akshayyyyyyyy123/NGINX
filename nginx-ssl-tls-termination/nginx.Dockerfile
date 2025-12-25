# pull the nginx alpine base image
FROM nginx:alpine

# remove the default nginx log files as they base image has default symlink which directs the output logs to /dev/stdout and /dev/stderr
RUN rm -rf /var/log/nginx/*.log && \
    mkdir -p /var/log/nginx && \
    touch /var/log/nginx/access.log && \
    touch /var/log/nginx/error.log

####################################################################
# Certificates should be handled by mounting them via the          #
# docker-compose.yaml file. That's how the K8s secrets, cert       #
# rotation and real infra works.                                   #
#                                                                  #
# However it's not a good practice to bake the certificates        #
# as part of image. This is because, certificates are runtime      #
# secrets. Mixing them is bad practice.                            #
#                                                                  #
####################################################################   

# RUN mkdir -p /etc/nginx/ssl && \
#    touch /etc/nginx/ssl/cert.pem && \
#    touch /etc/nginx/ssl/key.pem 

# copy the application code to nginx html directory
COPY frontend/ /usr/share/nginx/html

# copy the custom nginx conf file to the nginx conf directory
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# expose port 443 for the documentation of the service
EXPOSE 443

# start nginx in foreground mode
CMD ["nginx", "-g", "daemon off;"]