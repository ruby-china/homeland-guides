---
title: Apple Push Notification 配置
---

# Apple Push Notification 配置

Homeland 有开源的 iOS 客户端，你可以自行打包并发布 iOS App。

https://github.com/ruby-china/ruby-china-ios

## 配置 Apple Push 通知

访问 https://developer.apple.com/account

进入 **Certificates, Identifiers & Profiles** / [Create a New Certificate](https://developer.apple.com/account/resources/certificates/add)

并选择 **Services** / **Apple Push Notification service SSL (Sandbox & Production)**，然后点击 “Continue” 按钮进入下一步。

下一步，从下拉列表选择 App ID，比如 Ruby China 的是：“A38T799N53.org.ruby-china.app”。

Upload a Certificate Signing Request 这个步骤，你需要在 macOS 里面打开 “钥匙串访问”，并在点击主菜单 / 证书助理 / 从证书颁发机构请求证书。

在证书对话框输入电子邮件地址，然后请求是：选择存储到磁盘，这样我们可以得到一个 `CertificateSigningRequest.certSigningRequest`。

回到刚才的 Apple 网页，点击 “Choose File” 选择 `CertificateSigningRequest.certSigningRequest` 上传，并点击 “Continue”。

这样你就完成了证书申请，点击 “Download”，你可以获得一个 `aps.cer`。

## 生成 Homeland 需要的证书信息

在 Finder 里面找到 `aps.cer` 双击导入到 “钥匙串访问”，然后我们到 “钥匙串访问” 里面找到它（我的证书 里面）。

选中刚才导入的证书，从右键菜单中点击 “导出证书”，并选择文件格式：“个人信息交换 (.p12)”，存储为 `cert.p12`，并不要设置密码。

现在你会获得一个 `cert.p12`。

### 导出 pem 文件

打开终端，进入 `cert.p12` 所在的目录，并执行，将 `p12` 转换为 `cert.pem`：

```bash
$ openssl pkcs12 -in cert.p12 -out cert.pem -nodes -clcerts
```

查看 `cert.pem` 的内容（也可以用文本编辑器打开）：

```bash
$ cat cert.pem
```

复制 `cert.pem` 的全部内容，将它配置到 Homeland 后台的 **全局设置** / **apns_pem** 配置项里面，并保存。
