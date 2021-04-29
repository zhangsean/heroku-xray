FROM teddysun/xray
RUN apk add --no-cache acme.sh socat gettext nginx \
 && mkdir /run/nginx \
 && sed -ie 's/80/18080/g; 10 d; 9 a root /var/www;\nautoindex on;' /etc/nginx/conf.d/default.conf \
 && echo "Hello World" > /var/www/index.html
ADD config_client /var/www
ADD config.json /etc/xray/config.json
ADD entrypoint.sh /
CMD /entrypoint.sh
