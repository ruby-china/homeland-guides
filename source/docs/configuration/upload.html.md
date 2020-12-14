---
title: 文件上传配置
---

# 文件上传配置

Homeland 目前支持两种文件存储方式：

- File - 本地存储
- [UpYun](http://upyun.com)
- [Aliyun OSS](https://www.aliyun.com/product/oss)

在部署之前，你需要选择一种，并购买，然后根据下面的文档配置 Homeland。

| 配置项               | 解释                                     | 需要重启? |
| -------------------- | ---------------------------------------- | --------- |
| upload_provider      | 文件存储方式 [`file`, `upyun`, `aliyun`] | 是        |
| upload_access_id     | 文件存储 `access_id` 或用户名            | 是        |
| upload_access_secret | 文件存储 `access_secret` 或密码          | 是        |
| upload_bucket        | 文件存储 Bucket 名称                     | 是        |
| upload_url           | 文件存储的 Host                          | 是        |

## File

本地存储上传文件，存放在 public/uploads 目录下。

> NOTE: file 模式无法实现分布式部署哦！我们建议使用 UpYun 或 Aliyun 这样既有很好的响应速度，也无需额外备份本地文件。

File 模式需要 Nginx [image_filter](http://nginx.org/en/docs/http/ngx_http_image_filter_module.html) module 配合才能生存缩略图。
安装比较复杂，如果技能不熟练，请采用 Docker 模式部署。

```conf
# [uploader]
upload_provider=file
# upload_host 留空
upload_host=
```

## UpYun

```conf
# [uploader]
upload_provider=upyun
upload_access_id=username
upload_access_secret=password
upload_bucket=your-bucket
upload_url=http://your-bucket.b0.upaiyun.com
```

## Aliyun OSS

> 创建 Bucket 的时候，请选择 `公共读` 模式。

Aliyun OSS 相比 UpYun 多了两项配置:

| 配置项                 | 解释                                                       | 需要重启? |
| ---------------------- | ---------------------------------------------------------- | --------- |
| upload_aliyun_internal | 如果是阿里云的服务器，这里设置 true 将能获得更快的上传速度 | 是        |
| upload_aliyun_area     | 阿里云服务器区域，例如: `cn-shanghai`                      | 是        |

例如：

```conf
upload_provider=aliyun
upload_access_id=access-id
upload_access_secret=access-secret
upload_bucket=your-bucket
upload_url=http://your-bucket.host.com
upload_aliyun_internal=false
upload_aliyun_area=cn-shanghai
```

## Qinniu

```conf
upload_provider=qiniu
upload_access_id=your-qiniu-access-key
upload_access_secret=your-qiniu-secret-key
upload_bucket=your-qiniu-bucket-name
upload_url=http://your.qiniu.domian.name.com
```

## 图片缩略图

Hoemeland 上传图片需要依赖云服务的图片缩略图功能。

- UpYun: [云处理](http://docs.upyun.com/guide/#_12) - 需进入 UpYun 管理后台配置缩略图版本。
- Aliyun: [图片处理](https://help.aliyun.com/document_detail/44688.html) - 无须配置。
- Qiniu: [图片处理](https://developer.qiniu.com/dora/manual/1279/basic-processing-images-imageview2) - 无须配置。

### 开启 **间隔标识符**

UpYun 使用感叹号 `!` (应该默认已开启)， `Aliyun` 和 `Qiniu` 无需配置，Homeland 内置支持。

### 缩略图版本

请在对应的平台管理界面按下面的表格设置 **缩略图版本**：

| 版本名称 | 限定尺寸 (px) | 缩略方式             |
| -------- | ------------- | -------------------- |
| large    | 1920          | 限定宽度，高度自适应 |
| lg       | 192x192       | 固定宽度和高度       |
| md       | 96x96         | 固定宽度和高度       |
| sm       | 48x48         | 固定宽度和高度       |
| xs       | 32x32         | 固定宽度和高度       |

例如: <a href="/images/docs/upload-version-example.png">UpYun 的部分配置截图</a>

## 开启 CORS 跨域共享

个人设置页面有通过 AJAX 请求强制刷新头像缓存的动作，你需要配置 UpYun 开启 [CORS 跨域共享](http://docs.upyun.com/cdn/feature/#cors) 功能：

| 允许的域             | Methods            | Allow Headers | Expose Headers |
| -------------------- | ------------------ | ------------- | -------------- |
| http://your-host.com | GET, HEAD, OPTIONS | Pragma        | Pragma         |

> NOTE: 允许的域注意 http 还是 https，确保和你正常访问你网站的地址一样，例如: https://ruby-china.org
