FROM teddysun/xray
RUN apk add --no-cache acme.sh socat gettext nginx \
 && mkdir /run/nginx \
 && sed -ie 's/80/18080/g; 10 d; 9 a root /var/www;\nautoindex on;' /etc/nginx/conf.d/default.conf \
 && echo "Hello World" > /var/www/index.html \
 && curl -sSL https://github.com/cloudflare/wrangler/releases/download/v1.16.1/wrangler-v1.16.1-x86_64-unknown-linux-musl.tar.gz | tar zxf - \
 && mv dist/wrangler /usr/bin/ \
 && rm -rf dist/
ADD config_client /var/www
ADD config.json /etc/xray/config.json
ADD entrypoint.sh /
CMD /entrypoint.sh
