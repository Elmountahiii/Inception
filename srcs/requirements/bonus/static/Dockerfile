# Use Debian 11 (Bullseye) as base image
FROM debian:11

# Update package lists and install nginx
RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the HTML file to the nginx html directory
COPY ./conf/index.html /var/www/html/

# Remove the default nginx welcome page
RUN rm -f /var/www/html/index.nginx-debian.html

# Expose port 80
EXPOSE 80

# Configure nginx to stay in foreground
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Command to run when the container starts
CMD ["nginx"]