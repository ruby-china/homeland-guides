# 开启 SSL 功能，以支持 HTTPS 的方式访问

> since: 2.8.1

Homeland 内建自动化 SSL 证书管理工具，以及关于 SSL 的一系列配置功能。

自 Homeland 2.8.1 版本开始，继承 [Caddy Server](https://caddyserver.com/) 作为 Web 前端，并自动管理 SSL 证书。正常情况下，你应该不需要在关心 SSL 证书的问题。

> Homeland <= 2.8.1 请阅读 [旧版本 SSL 的文档](/docs/ssl-legecy/)。

## 准备

1. 确定 `app.local.env` 里面有正确配置 `domain` 为你的域名；
2. 确保域名正确绑定到服务器的外网 IP 上；

## 开启 SSL 的配置

打开 `app.local.env`，修改 `domain` 配置项:

```conf
domain=your-host.com
```

## 启动服务

配置好 `domain` 并确保域名已经绑定到服务器外网 IP 以后，你可以直接启动，接下来内部将会自动处理 SSL 证书申请，以及定期续期等工作。

```bash
sudo make start
```
