# [Homebrew](http://brew.sh/index_zh-cn.html)

## install

`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

## brew usage

| 命令 | 说明 |
| --- | ---- |
|brew update |	更新 brew
|brew search FORMULA |	查找软件包，可使用正则表达式|
|brew info FORMULA |	显示软件的信息|
|brew deps FORMULA |	显示包依赖|
|brew install FORMULA |	安装软件包|
|brew uninstall FORMULA|卸载软件包|
|brew list	|列出已安装的软件包，可指定 FORMULA|
|brew outdated|	列出可升级的软件包|
|brew upgrade	|更新已安装的软件包，可指定 FORMULA|
|brew doctor|	诊断 homebrew 环境|
|brew prune	|删除 /usr/local 下的无效链接(remove broken symlinks)|

## [Homebrew-cask](https://caskroom.github.io/)

install: `brew install caskroom/cask/brew-cask`

### 特别注意

homebrew-cask 是将应用程序放置在/opt/homebrew-cask/Caskroom/下，会在你的家目录中的「应用程序」文件夹中创建一个类似快捷方式的替身。在Finder的偏好设置中，第三个侧边栏勾选上你的家目录，这样找应用会方便一些。但不用太担心你，Launchpad是会找到这个目录下的应用的，需要Alfred支持请查看brew cask alfred。


## other

### iTerm2

iTerm2设置为默认终端：`（菜单栏）iTerm -> Make iTerm2 Default Term`

[配色方案](http://iterm2colorschemes.com/)，下载完成后依次选择：iTerm->Preferences->Profiles->Colors，然后选择下面的Load Presets->Import，选择下载好的schemes文件夹里面的.itermcolors后缀的文件导入主题即可选择使用。

* 常用的快捷键：

```
⌘ + n                   // 新建term窗口
⌘ + t                   // 新建标签页
⌘ + w                   // 关闭标签页或者窗口
⌘ + d / ⌘ + shift + d   // 分屏显示
⌘ + 数字 / ⌘ + <- / ->   // tab标签页之间切换
⌘ + ;                   // 自动补全
```

自定义一些快捷键，在`iTerm->Preferences->Keys`里面设置

### proxychains-ng

* conf

`vim /usr/local/Cellar/proxychains-ng/4.11/etc/proxychains.conf`

```
socks5 127.0.0.1 1080
# or
http 127.0.0.1 8080
```