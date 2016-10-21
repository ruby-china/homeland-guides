---
title: Upload Configuration
---

# Upload Configuration

Homeland 目前支持两种文件存储方式：

- [UpYun](http://upyun.com)
- [Aliyun OSS](https://www.aliyun.com/product/oss)

在部署之前，你需要选择一种，并购买，然后根据下面的文档配置 Homeland。

| 配置项 | 解释 | 需要重启? |
|--------|--------------|----------------|
| upload_provider | 文件存储方式 [`upyun`, `aliyun`] | 是 |
| upload_access_id | 文件存储 `access_id` 或用户名 | 是 |
| upload_access_secret | 文件存储 `access_secret` 或密码 | 是 |
| upload_bucket | 文件存储 Bucket 名称 | 是 |
| upload_url | 文件存储的 Host | 是 |

## UpYun

config/config.yml

```yml
defaults: &defaults
  upload_provider: "upyun"
  upload_access_id: "username"
  upload_access_secret: "password"
  upload_bucket: "your-bucket"
  upload_url: "http://your-bucket.b0.upaiyun.com"
```

## Aliyun OSS

config/config.yml

Aliyun OSS 相比 UpYun 多了两项配置:

| 配置项 | 解释 | 需要重启? |
|--------|--------------|----------------|
| upload_aliyun_internal |  如果是阿里云的服务器，这里设置 true 将能获得更快的上传速度 | 是 |
| upload_aliyun_area | 阿里云服务器区域，例如: `cn-shanghai` | 是 |

例如：

```yml
defaults: &defaults
  upload_provider: "aliyun"
  upload_access_id: "access-id"
  upload_access_secret: "access-secret"
  upload_bucket: "your-bucket"
  upload_url: "http://your-bucket.host.com"
  upload_aliyun_internal: false
  upload_aliyun_area: "cn-shanghai"
```

## 图片缩略图

Hoemeland 上传图片需要依赖云服务的图片缩略图功能。

- UpYun: [云处理](http://docs.upyun.com/guide/#_12)
- Aliyun: [图片处理](https://help.aliyun.com/document_detail/31917.html)

请在对应的平台管理界面按下面的表格设置 **缩略图版本**：

| 版本名称| 限定尺寸 (px) | 缩略方式           |
|--------|-----|          ------------------|----
| large  |1920 |           限定宽度，高度自适应 |
| lg     |192x192 |        固定宽度和高度      |
| md     |96x96 |          固定宽度和高度      |
| sm     |48x48 |          固定宽度和高度      |
| xs     |32x32 |          固定宽度和高度      |

例如: <a href="/images/docs/upload-version-example.png">UpYun 的部分配置截图</a>


