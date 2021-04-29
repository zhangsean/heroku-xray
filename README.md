# heroku-xray

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

在 Heroku 上部署 [Xray VLESS-TCP-XTLS-WHATEVER](https://github.com/XTLS/Xray-examples/tree/main/VLESS-TCP-XTLS-WHATEVER)，实现 VLESS over TCP with XTLS + 回落 & 分流 to WHATEVER（终极配置）。

---

这里是 [进阶配置](https://github.com/XTLS/Xray-examples/tree/main/VLESS-TCP-TLS-WS%20(recommended)) 的超集，利用 VLESS 强大的回落分流特性，实现了 443 端口尽可能多的协议、配置的完美共存，包括 [XTLS Direct Mode](https://github.com/rprx/v2fly-github-io/blob/master/docs/config/protocols/vless.md#xtls-%E9%BB%91%E7%A7%91%E6%8A%80)

客户端可以同时通过下列方式连接到服务器，其中 WS 都可以通过 CDN

1. [VLESS over TCP with XTLS](https://myxray.myname.workers.dev/vless_tcp_xtls.json)，数倍性能，首选方式
2. VLESS over TCP with TLS
3. VLESS over WS with TLS
4. VMess over TCP with TLS，不推荐
5. VMess over WS with TLS
6. Trojan over TCP with TLS

---

这里设置默认回落到 Xray 的 Trojan 协议，再继续回落到 80 端口的 Web 服务器（也可以换成数据库、FTP 等）

## 部署步骤

* 点击上方 `Deploy to Heroku` 按钮，重定向到Heroku新增APP界面。
* 输入 `App name`，比如`myxray`。
* 访问 [uuid.online](http://www.uuid.online/) 获取一个随机 UUID 填写到 `UUID` 参数中，比如`9f6ef794-04fd-4961-bc6f-d2bcfebe4649`。
* 输入这个 Heroku App 的访问域名，比如`myxray.herokuapp.com`。如果要使用 Cloudflare CDN 加速，请先部署好`Worker`并输入`Worker`的域名，比如`myxray.myname.workers.dev`。
* 点击 `Deploy app` 按钮，等待部署完成。

## 客户端配置

参考 [Xray VLESS-TCP-XTLS-WHATEVER client config](https://github.com/XTLS/Xray-examples/tree/main/VLESS-TCP-XTLS-WHATEVER/config_client) 配置。
