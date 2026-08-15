FROM nginx:alpine

RUN echo "Hello from Jenkins Docker CI/CD" > /usr/share/nginx/html/index.html

EXPOSE 80
