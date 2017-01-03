---
title: 邮件服务配置
---

# 邮件服务配置

Homeland 会有一系列的邮件通知，例如：注册成功、找回密码、账号锁定 等...

你需要在准备好邮件发送服务，可以是：

- [Postmark](https://postmarkapp.com) - 一个国外的邮件发送服务
- SMTP - 几乎所有的邮件服务提供商都支持 SMTP 的方式

## SMTP 配置

你可以寻找一个支持邮件发送服务器的地方，注册一个自己网站域名的 SMTP 服务，并参考下面的配置（Gmail）：

> NOTE: 参考 Gmail 官方 [SMTP 配置指导](https://support.google.com/mail/answer/7126229?hl=zh-Hans)

普通模式配置: `config/config.yml`

```yml
default: &default
  mailer_provider: 'smtp'
  mailer_sender: 'no-relay@your-domain.com'
  mailer_options:
    address: 'smtp.gmail.com'
    port: 587
    domain: 'your-domain.com'
    user_name: 'no-reply@your-domain.com'
    password: 'your-password'
    authentication: 'plain'
    enable_starttls_auto: true
    # openssl_verify_mode: true
```

> NOTE: mailer_provider 为 `smtp` 的时候 mailer_options 各项配置的解释详见: [Rails Guides - Action Mailer Configuration](http://guides.rubyonrails.org/action_mailer_basics.html#action-mailer-configuration) 的 `smtp_settings` 配置项（mailer_options 完全等于 smtp_settings）。

Docker 模式，配置 `app.local.env`

```conf
mailer_provider=smtp
mailer_sender=no-reply@your-domain.com
mailer_options.address=smtp.gmail.com
mailer_options.port=587
mailer_options.domain=your-domain.com
mailer_options.user_name=no-reply@your-domain.com
mailer_options.password=your-password
mailer_options.authentication=plain
mailer_options.enable_starttls_auto=true
````


## Postmark

访问 [Postmark](https://postmarkapp.com) 官方网站注册，并购买邮件服务，并获得 `app_key`

```yml
default: &default
  mailer_provider: 'postmark'
  mailer_sender: 'no-relay@your-domain.com'
  mailer_options:
    api_key: 'your-postmark-api-key'
```

## 如何测试

你只需要启动应用，并尝试找回密码功能，看看邮件是否正确收到。