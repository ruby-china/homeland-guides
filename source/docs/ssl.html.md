# 开启 SSL 功能，以支持 HTTPS 的方式访问

> since: 2.5.0

Homeland 内建 [Let's Encrypt](https://letsencrypt.org) 的 SSL 证书申请流程，以及关于 SSL 的一系列配置功能。

如果你使用 Docker 的方式部署 Homeland，你可以轻松开启 SSL 功能，只需要执行 `make install_ssl` 命令即可申请 SSL 并自动配置上。

## 准备

1. 确定 `app.local.env` 里面有正确配置 `domain` 为你的域名。
2. 确保域名正确绑定到服务器上，并能访问打开；
3. 一定确保网站服务器能用，因为 SSL 申请过程，需要请求网站 http://your-domain/.well-known 路径，如果无法访问，后面的流程将会失败。

## 申请安装 SSL 正确

```bash
$ sudo make install_ssl
```

> 过程有很多信息，请注意红色的，如果有问题，请将过程的所有信息在 GitHub 提交 Issue

如果一切顺利，你将在最后看到类似这样的提示:

```
---------------------------------------------
SSL install successed.

Now you need enable https=true on app.local.env config.
And then restart by run: make restart
```

以及 `homeland-docker/shared/ssl` 目录将会出现一些新的文件。

## 开启 SSL 的配置，并重启服务

打开 `app.local.env`，修改 `https` 配置项:

```conf
https=true
```

然后重启服务:

```bash
sudo make restart
```

> NOTE: 当然开启 https=true 以后，Homeland 将会以强制 SSL 的方式运行，访问 HTTP 协议的请求将自动跳转到 HTTPS 协议。

打开，测试你的网站。