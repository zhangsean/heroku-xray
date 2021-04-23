#!/bin/sh
sed -i "s|80;|$PORT;|g" /etc/nginx/conf.d/default.conf
sed -i "s|nginx!|nginx! <br/>Deploy by <i>$NAME</i>!|g" /usr/share/nginx/html/index.html
nginx -g "daemon off;"
