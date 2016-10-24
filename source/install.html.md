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

下面的脚本是增对 Ubuntu Server 14.04 设计的，其他版本，请查阅 [Docker 官方的安装文档](https://docker.github.io/engine/installation/linux/)。

```bash
curl -sSL https://git.io/vPALl | bash
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

默认情况下，Homeland 自带了基础的配置，但你仍然需要进行一系列的配置以后才可正常使用所有功能。

### 编译环境

> 前面的脚本安装以后，docker 需要用 `sudo` 来执行，切记！

```bash
sudo make install
```

### 启动

```bash
sudo make start
```

## 命令列表

> 在 Linux 环境里面，前面的脚本安装以后，docker，以及一下这些命令需要用 `sudo` 来执行，切记！

| Command | Desc |
|---------|------|
| make install | 首次安装，创建数据库 |
| make update | 更新应用程序，重新编译，此方法可以更新最新的 Ruby China 代码 |
| make start | 启动所有服务，将会自动启动所有的服务 |
| make stop | 停止所有服务 |
| make restart | 硬重启服务 |
| make status | 查看服务状态 |
| make console | 进入 Rails 控制台 |
| make stop-all | 停止所有服务，包括数据库 |
| make reindex | 重建搜索索引 |