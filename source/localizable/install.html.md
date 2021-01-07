---
title: Install Homeland with Docker - Homeland
---

## Homeland Docker

[Homeland](http://gethomeland.com) builit on Docker for automated deploy.

## System requirements

- Linux Server [4 Core CPU, 4G Memory, 50G Disk, 64 bit] - _Better use Ubuntu Server 14.04_
- [Docker](https://www.docker.com/), [Docker Compose](https://docs.docker.com/compose/)

## Usage

### Install Docker:

This script was made for Ubuntu Server 14.04, If you use other system version, please read [Docker Installaction](https://docker.github.io/engine/installation/linux/).

```bash
curl -sSL https://git.io/install-docker | bash
```

#### Run Docker commands without sudo

##### 1. Add the `docker` group if it doesn't already exist

```console
$ sudo groupadd docker
```

##### 2. Add the connected user `$USER` to the docker group

Optionally change the username to match your preferred user.

```console
$ sudo gpasswd -a $USER docker
```

##### 3. Restart the `docker` daemon

```console
$ sudo service docker restart
```

If you are on Ubuntu 14.04-15.10, use `docker.io` instead:

````console
$ sudo service docker.io restart
``

### Test Docker

```bash
docker info
docker-compose version
````

### Get homeland-docker

```bash
git clone https://github.com/ruby-china/homeland-docker.git
cd homeland-docker/
```

## Application configuration

Homeland use `app.local.env` file to config, there have an example in `app.default.env`. You must read the [Configuration](/docs/configuration/config-file/) and customize the config varibles with your application.

**Required settings**

Please edit `app.local.env` file:

```conf
# For auto SSL get cert
domain=your-host.com
# default: admin@admin.com, when you use this email register a user, you will get the admin role.
# Or you can change it as your email.
admin_emails=admin@admin.com
```

## Install

```bash
make install
```

## Startup

```bash
make start
```

Now, you can visit https://your-host.com

## Commands

| Command       | Desc                                                   |
| ------------- | ------------------------------------------------------ |
| make install  | For first install, create database                     |
| make update   | Update docker image and restart application for update |
| make start    | Startup application                                    |
| make stop     | Stop application containers (except Database, Redis)   |
| make restart  | Restart application                                    |
| make status   | Show container status                                  |
| make console  | Enter the Rails console                                |
| make stop-all | Stop all services (including Databse, Redis)           |
| make reindex  | Rebuild Search indexes                                 |
