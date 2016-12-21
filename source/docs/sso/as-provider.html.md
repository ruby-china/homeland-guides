# 作为 Single Sign On 提供者 (SSO Provider)

> version: 2.4.0

Homeland 支持 [Single Sign On](https://en.wikipedia.org/wiki/Single_sign-on)，可以让你将 Homeland 无缝的和现有应用结合，实现统一登录的功能。

本文是介绍如何将 Homeland 作为主的账号系统，三方应用通过 Homeland 来实现 SSO 同步账号登陆。

## 参数信息

- sso_url: http://you-homeland-app.com/auth/sso/provider
- sso_secert: 基于配置文件

## 配置启用 SSO Provider

请参阅 Homeland [配置文档](/docs/configuration/config-file)，并增加下面这些配置:

| 配置项 | 解释 | 需要重启? |
|--------|--------------|----------------|
| sso.enable_provider | true 启用 SSO Provider | 是 |
| sso.secret | sso_secret，三方应用接入 Homeland SSO 登陆需要统一此 sso_secret，请确保两边一致，并注意保密 | 是 |

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

## 演示例子

假定现在有个 Blog，需要基于 Homeland 的账号体系实现 SSO 登陆

```rb
class ApplicationController < ActionController::Base
  # 验证是否已经登陆，为登陆跳转到 Homeland 的 SSO 地址
  def require_sso!
    if !session[:user]
      sso = SingleSignOn.new
      sso.return_sso_url = 'http://your-blog-app.com/sso_login'
      sso.sso_url = "http://your-homeland-app.com/auth/sso/provider"
      sso.sso_secret = 'YOUR_HOMELAND_SSO_SECRET'
      redirect_to sso.to_url
    end
  end
end

class BlogController < ApplicationController
  before_action :require_sso!

  # GET /blog
  def index
  end

  # GET /blog/new
  def new
  end
end

class SessionsController < ActionController::Base
  # GET /sso_login
  def sso_login
    sso = SingleSignOn.parse(request.query_string, 'YOUR_HOMELAND_SSO_SECRET')
    user = User.new
    user.username = sso.username
    user.email = sso.email
    user.name = sso.name
    user.avatar_url = sso.avatar_url
    user.bio = sso.bio
    session[:user] = user
    # 根据需要选择是否实现关联账号，并将 Homeland 传过来的用户信息存入数据库
    redirect_to '/blog/new'
  end
end
```
