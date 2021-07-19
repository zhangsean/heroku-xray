#!/bin/sh
wrangler init
echo $CF_KV_API_TOKEN | wrangler config
ACCOUNT_ID=`wrangler whoami | sed -n '/s Account/s/.*Account | \(.*\) |/\1/p'`
sed -i "/account_id/s/''/'$ACCOUNT_ID'/" wrangler.toml
wrangler kv:key get cer -n $CF_KV_NAMESPACE_ID > ssl.cer
if grep 'key not found' ssl.cer; then
    rm -f ssl.cer
    acme.sh --issue --standalone -d $DOMAIN --httpport $PORT --tlsport $PORT
    ln -s ~/.acme.sh/$DOMAIN/fullchain.cer ssl.cer
    ln -s ~/.acme.sh/$DOMAIN/$DOMAIN.key ssl.key
    wrangler kv:key put -n $CF_KV_NAMESPACE_ID cer ssl.cer --path
    wrangler kv:key put -n $CF_KV_NAMESPACE_ID key ssl.key --path
else
    wrangler kv:key get key -n $CF_KV_NAMESPACE_ID > ssl.key
fi
envsubst < /xray/config.json > /etc/xray/config.json
cd /xray/client
for f in $(ls -1 *.json); do envsubst < $f > /var/www/$f; done
nginx
xray -c /etc/xray/config.json
