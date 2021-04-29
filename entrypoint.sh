#!/bin/sh
wrangler init
echo $CF_KV_API_TOKEN | wrangler config
ACCOUNT_ID=`wrangler whoami | sed -n '/s Account/s/.*Account | \(.*\) |/\1/p'`
sed -i "/account_id/s/''/'$ACCOUNT_ID'/" wrangler.toml
wrangler kv:key get cer -n $CF_KV_NAMESPACE_ID > ssl.cer
if grep 'key not found' ssl.cer; then
    acme.sh --issue --standalone -d $DOMAIN --httpport $PORT --tlsport $PORT
    ln -s ~/.acme.sh/$DOMAIN/fullchain.cer ssl.cer
    ln -s ~/.acme.sh/$DOMAIN/$DOMAIN.key ssl.key
    wrangler kv:key put -n 4d7b910f88a846329264bf31cc3f45db cer ssl.cer --path
    wrangler kv:key put -n 4d7b910f88a846329264bf31cc3f45db key ssl.key --path
else
    wrangler kv:key get key -n $CF_KV_NAMESPACE_ID > ssl.cer
fi
for f in $(ls -1 /var/www/*.json); do envsubst < $f > $f; done
envsubst < /etc/xray/config.json > /etc/xray/config.json
nginx
/usr/bin/xray -c /etc/xray/config.json
