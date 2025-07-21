FROM nginx:alpine

RUN apk update
RUN apk upgrade
RUN apk add bash yq

# Copy the HTML files into the Nginx server
COPY frontend/frontend-config.sh /docker-entrypoint.d/.
RUN chmod +x /docker-entrypoint.d/frontend-config.sh
RUN chown nginx:nginx /docker-entrypoint.d/frontend-config.sh
COPY frontend/. /usr/share/nginx/html/.