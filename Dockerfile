FROM nginx:stable-alpine
COPY ./files/index.html /var/www/html/index.html
COPY ./files/default.conf /etc/nginx/conf.d/default.conf
COPY ./files/redirections.conf /etc/nginx/sites-available/redirections.conf
