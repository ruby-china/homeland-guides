---
title: Install Homeland with Docker - Homeland
---

Homeland Docker
-----------------

[Homeland](http://gethomeland.com) 基于 Docker 的自动化部署方案。

## 系统需求

- Linux Server [4 Core CPU, 4G Memory, 50G Disk, 64 位] - _建议 Ubuntu Server 14.04_
- [Docker](https://www.docker.com/), [Docker Compose](https://docs.docker.com/compose/)
- [Aliyun OSS](https://www.aliyun.com/product/oss) 或 [UpYun](https://www.upyun.com) 用于文件存储。

## Usage

### 安装 Docker:

下面的脚本是针对 Ubuntu Server 14.04 设计的，其他版本，请查阅 [Docker 官方的安装文档](https://docker.github.io/engine/installation/linux/)。

```bash
curl -sSL https://git.io/install-docker | bash
```

测试是否安装成功：

```bash
sudo docker info
sudo docker-compose version
```

### 获取 homeland-docker 的项目

```bash
git clone https://github.com/ruby-china/homeland-docker.git
cd homeland-docker/
```

## 应用程序配置

Homeland 的应用程序配置主要基于 `app.local.env` 文件，请参考 `app.default.env`，以及阅读 [Config File](/docs/configuration/config-file/) 理解各项配置信息的含义，根据自己的需要调整。

> NOTE: Docker 模式依靠环境变量文件 `app.local.env` (此文件需要手工创建) 来配置应用，理论上你不需要修改 `config/config.yml`，除非你知道如何配置。

默认情况下，Homeland 自带了基础的配置，但你仍然需要进行一系列的配置以后才可正常使用所有功能。

**必要设置**

请修改 `app.local.env` 做一些必要的设置

1. 增加 `app_name` 设置网站名称；
2. 增加 `domain` 设置网站的域名（并确保域名 DNS 绑定到你的主机的 IP）
3. 增加 `admin_emails`，增加一个管理员 Email （多个管理员 Email，用英文逗号分隔）。

`app.local.env` 配置例如：

```conf
app_name=网站名称
domain=your-host.com
# 默认 admin@admin.com，你可以按你的需要修改，这里设置可以覆盖默认配置
admin_emails=admin@admin.com
```

> 稍后等 Web 服务启动起来以后，你可以用这个 Email 来注册一个新账号，新账号将会有管理员权限。


## 编译环境

> 前面的脚本安装以后，docker 需要用 `sudo` 来执行，切记！

```bash
sudo make install
```

## 启动

```bash
sudo make start
```

然后服务将会以 80, 443 端口的方式跑在你的服务器上，Nginx 什么的都已经配置好了，你只需要访问你之前配置的域名即可（别忘了域名解析配置到你的服务器 IP 哦），例如 http://your-host.com

## 注册管理员

打开网站，并打开注册页面，用刚才设定的 `admin_emails` 的 Email 账号（如果没有设置，可以使用默认的 `admin@admin.com`）注册新账号，完成步骤，并登陆以后，你可以点击 “导航栏” 右侧的 “用户头像”，弹出下拉菜单，并点击 “后台”，进入到管理后台界面。

或者可以直接访问 http://your-host.com/admin 进入管理后台。

## 命令列表

> 在 Linux 环境里面，前面的脚本安装以后，docker，以及一下这些命令需要用 `sudo` 来执行，切记！

| Command | Desc |
|---------|------|
| make install | 首次安装，创建数据库 |
| make install_ssl | 安装并申请 SSL 证书 (since: 2.5.0) |
| make update | 更新应用程序，当 `homeland/homeland` 这个 Docker Image 版本变化的时候，需要执行，合并数据库、编译 Assets |
| make start | 启动所有服务，将会自动启动所有的服务 |
| make stop | 停止所有服务 |
| make restart | 硬重启服务 |
| make status | 查看服务状态 |
| make console | 进入 Rails 控制台 |
| make stop-all | 停止所有服务，包括数据库 |
| make reindex | 重建搜索索引 |
