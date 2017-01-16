## mac 快捷键

**Shortcut** | **Function**
------------- | ----------
`Ctrl` + `space` | 输入法切换
Ctrl + Shift + Power | 关闭屏幕
Cmd + Opt + Power | 睡眠 (sleep)
Cmd + Ctrl + Power | 重启 (restart)
Cmd + Ctrl + Opt + Power | 关机 (shutdown)

## software

software | note 
--- | ---- 
Amphetamine | 防止系统休眠 Better than Caffeine

* sougouinput

install `brew cask install sougouinput`

then `open /usr/local/Caskroom/sogouinput/{versions}/安装搜狗输入法.app`

## proxychains-ng

### conf

`vim /usr/local/Cellar/proxychains-ng/4.11/etc/proxychains.conf`

```
socks5 127.0.0.1 1080
# or
http 127.0.0.1 8080
```

## lxml

```
brew install libxml2 --with-python
pip install lxml
```