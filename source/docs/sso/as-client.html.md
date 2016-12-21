# 通过三方应用实现 SSO 登录

> version: 2.5.0

Homeland 支持 [Single Sign On](https://en.wikipedia.org/wiki/Single_sign-on)，可以让你将 Homeland 无缝的和现有应用结合，实现统一登录的功能。

本文是介绍如何让 Homeland 通过三方应用实现 SSO 自动登录。

在你准备使用 Homeland 的时候，你可能已有一个网站，有自己的用户体系，例如：一个新闻网站。如果你希望 Homeland 自动通过这个新闻网站的账号体系来实现登录，你需要跟随下面的教程调整你的现有网站，以实现 Homeland SSO 功能的接入。

> NOTE: 本文涉及需要給原有应用编写代码的部分，需技术人员，部分演示代码采用 Ruby 语言编写，其他语言可作为参考。

## 准备

在实现之前你可以先阅读一下 Homeland SSO 接口的实现代码:

[ruby-china/homeland/blob/master/lib/single_sign_on.rb](https://github.com/ruby-china/homeland/blob/master/lib/single_sign_on.rb)

```rb
class SingleSignOn
  ACCESSORS         = [:nonce, :name, :username, :email, :avatar_url, :bio, :external_id, :return_sso_url, :admin]
  FIXNUMS           = []
  BOOLS             = [:admin]
  NONCE_EXPIRY_TIME = 10.minutes

  attr_accessor(*ACCESSORS)
  attr_accessor :sso_secret, :sso_url

  def self.parse(payload, sso_secret = nil)
    sso = new
    sso.sso_secret = sso_secret if sso_secret
  ... 省略
end
```

请参考此文件实现一个 `SingleSignOn` 类，如果是 Ruby 你可以直接复制来使用。

> NOTE: `SingleSignOn` 类是参考 [Discourse](https://meta.discourse.org/t/official-single-sign-on-for-discourse/13045) 实现的，所以理论上来说 Discourse 支持哪些 SSO 登陆方式，在 Homeland 上面也是有效的。

在你的主应用中提供一个 (`sso.url`) 类似这样的  `http://your-app.com/homeland/sso` 的接口，并实现类似下面的代码：

```rb
class HomelandSsoController < ApplicationController
  def sso
    # sso_secret 需要和 Homeland 里面配置的 sso_secret 一致
    secret = "MY_SSO_SECRET_STRING"
    sso = SingleSignOn.parse(request.query_string, secret)
    # 以下的信息将会提供给 Homeland 作为用户信息同步
    sso.email = "user@email.com"
    sso.name = "Bill Hicks"
    sso.username = "bill@hicks.com"
    sso.bio = "This is bio of this user"
    sso.external_id = "123" # unique id for each user of your application
    sso.sso_secret = secret

    # 最后将准备好的信息计算成加密的 URL Query String 并跳转到 Homeland 应用的 SSO 登录地址 '/auth/sso/login'
    # Homeland 接收到信息以后，将会实现同步账号登陆的流程
    redirect_to sso.to_url("http://your-homeland-app.com/auth/sso/login")
  end
end
```

## 配置 Homeland

请参阅 Homeland [配置文档](/docs/configuration/config-file)，并增加下面这些配置:

| 配置项 | 解释 | 需要重启? |
|--------|--------------|----------------|
| sso.enable | true 启用 SSO 登陆，请确保 enable_provider 为 false，否则将无效 | 是 |
| sso.url | 主应用的 SSO 登陆地址 | 是 |
| sso.secret | 主应用提供的 sso_secret，请确保两边一致，并注意保密 | 是 |

## 参考链接

- [WordPress Page Template for SSO with Homeland](https://gist.github.com/huacnlee/f89bbe4b8350ba75435a2160ae5884a9)