# Use ultra-lightweight Nginx alpine image
FROM nginx:alpine

# Copy the web application single file to default Nginx html folder
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
