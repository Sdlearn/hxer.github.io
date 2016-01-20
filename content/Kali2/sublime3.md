---
title: "sublime text3"
date: 2016-01-20 21:38
---

## 官网下载deb包，安装

## 命令行输入：subl, 即可运行

## user 配置文件

```
{
"color_scheme": "Packages/Theme - Flatland/Flatland Monokai.tmTheme",
"theme": "Flatland Dark.sublime-theme",
"ensure_newline_at_eof_on_save": true,
"translate_tabs_to_spaces": true,
"trim_trailing_white_space_on_save": true,
"show_encoding": true,
"remember_full_screen": true,
"open_files_in_new_window": false,
"create_window_at_startup": false,
"close_windows_when_empty": false,
"ignored_packages": [],
}
```

## 安装包管理

选择：view->Show Console,复制如下内容后回车，稍等片刻后会提示重启即可（需要联网）

```
import urllib.request,os,hashlib; h = '2915d1851351e5ee549c20394736b442' + '8bc59f460fa1548d1514676163dafc88'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
```

快捷键：Prefernces->Key Bindingd - User
```
[ {"keys":["f5"],
    "caption": "SublimeREPL: Python - RUN current file",
    "command": "run_existing_window_command", "args":
    {
        "id": "repl_python_run",
        "file": "config/Python/Main.sublime-menu"
    }}
]
```



## 字体

* 安装文泉驿字体:

```
$sudo apt-get install xfonts-wqy
```
配置Sublime Text 3的Setting User,添加如下内容
```
"font_face": "WenQuanYi Micro Hei Mono"
```

## 输入中文

安装插件 InputHelper，用于输入中文

```
$cd ~/.config/sublime-text-3/Packages
$git clone https://github.com/xgenvn/InputHelper.git
```

到此，按下Ctrl + Shift + Z，输入中文；

## 插件

* Install SublimeREPL

Preferences | Package Control | Package Control: Install Package （enter）
Choose SublimeREPL

* Package Control
* git
* ]GitGutter

* Anaconda

```
setting-User:{
    "pep8": false,
    "complete_parameters": true,
    "complete_all_parameters": false,
    "pep8_ignore":
    [
         "E501"
    ],
}
```

* MarkdownPreview

```
setting-User:{
    /* Sets the parser used for building markdown to HTML. */
    "parser": "markdown",

    /* Enable or not mathjax support. */
    "enable_mathjax": true,

    "enable_highlight": true,

}
```