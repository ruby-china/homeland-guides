# Modules

Homeland 包含几大主要部件:

| Module Name |      名称      | 说明 |
|-------------|--------------|--------------|
| `home`        | 首页 | 禁用此项，首页直接指向话题列表 |
| `topic`       | 话题/论坛 | 基本功能，不可关闭 |
| `wiki`        | 百科 | |
| `site`        | 酷站 | |
| `note`        | 记事本 | |
| `team`        | 团队/组织 | |
| `github`      | GitHub 有关的功能：GitHub 登陆、个人主页 GitHub 仓库列表，个人设置 GitHub ... |

你可以根据实际需要选择性通过调整 [应用程序配置](/docs/configuration/config-file) 来开启某些功能或禁用某几个功能哦！

```yaml
production:
  # all 开启全部
  modules: home,topic,wiki,site,note,team,github
```

> NOTE: 调整 `modules` 配置项，需要重启应用。
