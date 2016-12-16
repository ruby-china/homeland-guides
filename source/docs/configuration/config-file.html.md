---
title: App configuration
---

# 应用程序配置

> NOTE: `app.default.env` 里面有默认配置可以参考哦，`app.local.env` 里面的配置信息将会覆盖 `app.default.env`，仅 Docker 部署需要。
> NOTE: 非 Docker 模式，配置文件在 `config/config.yml`

Homeland 包含一系列的配置参数，在项目的 `app.local.env` 包含 Homeland 的重要应用程序配置信息，你 **必须** 在首次部署应用程序之前，根据自己的实际情况调整这些配置。

你还可以在管理后台的 "全局设置" 界面调整这些配置（这里调整能立刻生效，无须重启），当你在“全局设置”界面调整某项配置
以后，配置信息的数据将写入到数据库中，`app.local.env` 里面对应的项将被忽略，以后需要在管理后台才能修改。

> NOTE: 注意，某些重要配置项修改以后是需要重启（Docker: `make restart`）的。

## 配置项

### 功能配置

| 配置项 |      解释      | 需要重启? |
|--------|--------------|----------------|
| app_name | 应用程序名称 | 是 |
| modules | 可拔插组件配置，详见: [Modules](/docs/configuration/modules) | 是 |
| domain | 网站域名，例如 www.foo.com | 是 |
| https | 开启 Homeland 的 SSL 功能（出了开启此项，还别忘了要对 Web 服务配置 SSL） | 是 |
| asset_host | 自定义网站静态资源文件的 Host，保持为空将不启用 | 是 |
| admin_emails | 管理员 Email 列表，当注册的账号 Email 在这个列表，将获得管理员权限（一行一个） | |
| google_analytics_key | Google Analytics 统计的 key | |
| mailer_provider | 邮件发送方式: [`smtp`, `postmark`] | 是 |
| mailer_sender | 邮件通知发件人 | 是 |
| mailer_options | 邮件服务详细配置，根据 `mailer_provider` 参数有可能不同，详见 [邮件服务配置](/docs/configuration/mailer) | 是 |
| github_token | GitHub 三方登录 Application Token | 是 |
| github_secret | GitHub 三方登录 Application Secret | 是 |
| default_locale | 应用程序语言，默认 "zh-CN"，可选 ['zh-CN', 'zh-TW', 'en'] | 是 |
| auto_locale | 是否自动根据用户浏览器设置，切换到相应的语言, true | false 默认 | 是 |

## 用户资料可选项

你可以根据实际需要开启某些用户字段
| 配置项 |      解释      | 需要重启? |
|--------|--------------|----------------|
| profile_fields | 配置用户资料开启的字段，默认 all 开启全部 | 是 |

#### 可选值:

- company - 所在公司
- twitter - Twitter
- website - 个人网站
- tagline - 签名
- location - 城市
- hr - HR 功能，HR 具有直接发帖权限，以及有特别的标示图表
- alipay - 支付宝账号
- paypal - PayPal 账号
- qq - QQ 号
- weibo - 微博
- wechat - 微信
- douban - Douban ID
- dingding - 钉钉
- aliwangwang - 阿里旺旺
- facebook - Facebook
- instagram - Instagram
- dribbble - Dribbble
- battle_tag - Battle Tag 战网账号
- psn_id - PSN ID (PS 游戏联网 ID)
- steam_id - Stream ID

例如:

```yml
profile_fields: 'twitter,facebook,wechat'
```

## 上传附件配置

详见: [Upload Configuration](/docs/configuration/upload)

## 高级设置

| 配置项 | 解释 | 需要重启? |
|--------|--------------|----------------|
| apns_pem | iOS - Apple Push Notification 证书，需要自定义 iOS 客户端可以配置此项，请打开 `.pem` 文件，将文件内容通过管理后台设置进去，.pem 导出方法 `openssl pkcs12 -in cert.p12 -out cert.pem -nodes -clcerts`，参见: [APNS](https://github.com/jpoz/APNS)。 | |
| newbie_limit_time | 新注册用户（新手）限制期，单位秒，在新手期不能创建新话题，仅能回帖。0 不限制, 默认 86400 (24 小时) | |
| reject_newbie_reply_in_the_evening | 设置 true 将不允许新手等级的账号在晚上 10 点到第二天 9 点这段时间回帖 | |
| rack_attack | 保持为空，不启用 | 是 |
| rack_attack.limit | 一个周期内单个 IP 的请求次数限制 | 是 |
| rack_attack.period | 多少时间（秒）为一个请求限制周期 | 是 |
| blacklist_ips | IP 黑名单，里面的 IP 将无法访问 | |
| ban_words_on_reply | 垃圾回帖过滤名单，一行一个 | |
| node_ids_hide_in_topics_index | 那些节点不需要在论坛首页显示，这里需要填写节点编号 | |
| tips | 随机出现的小贴士，一行一个 | |


### 自定义 HTML

Homeland 允许你在一些重要位置自由编写 HTML，以适应不同的应用场景，例如，你可能需要将网站的 Logo 改一下，或者覆盖默认的 CSS 风格。

> 支持管理后台“全局设置”界面实时调整

| 配置项 | 解释 |
|--------| -------------- |
| navbar_brand_html | 导航栏 Logo 位置 HTML，你可以设置你的 Logo |
| navbar_html | 导航栏扩展菜单，可以在顶部导航条增加扩展链接 |
| footer_html | 页面底部区域自定义 HTML，例如版权信息，次要链接等等 |
| index_html | 首页导航栏一下区域自定义 HTML |
| wiki_index_html | Wiki 首页自定义 HTML |
| wiki_sidebar_html | Wiki 页面左侧位置自定义 HTML |
| topic_index_sidebar_html | 论坛话题列表首页 (/topics) 右侧边栏自定义 HTML |
| custom_head_html | 页面 HTML `<head></head>` 区域自定义 HTML，你可以在这里写 CSS 覆盖，SEO 信息等等 |
| newbie_notices | 新手等级的会员将会看到的提示信息（HTML 语法) |



