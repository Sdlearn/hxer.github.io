---
title: "code editor"
date: 2016-01-20 21:38
---

# vscode

## 运行python

* press **Ctrl+Shift+B**

It will open a message saying "No task runner configured"

* Press "Configure Task Runner"

It will open/create the file .vscode/tasks.json

* Replace the instructions with

```
// A task runner that calls the Typescript compiler (tsc) and
// Compiles a HelloWorld.ts program

{
    "version": "0.1.0",
    "command": "python",
    "args": ["${fileBasename}"],
    "showOutput": "always"
}
```

this configure also for ** windows 10** to run

4. Go back to your Python file and press Ctrl+Shift+B again

It should run the code with python

## 安装插件

* 方法 1. Ctrl/Cmd+P (或 Ctrl/Cmd + E) 输入 ext install [插件关键字/名称]

* 方法 2. Ctrl/Cmd+Shift+P (或 F1) 输入 Extensions, 选中 Install Extension 然后输入插件名称/关键字.

* 不在插件商店的插件, 则可以放置到用户目录下的 .vscode/extensions 文件夹中~ 重启 VS Code 即可生效.

## 插件

* python

    + Magic Python


# sublime text3

* 官网下载deb包，安装

* 命令行输入：subl, 即可运行

* 安装包管理

选择：view->Show Console,复制如下内容后回车，稍等片刻后会提示重启即可（需要联网）

```
import urllib.request,os,hashlib; h = '2915d1851351e5ee549c20394736b442' + '8bc59f460fa1548d1514676163dafc88'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
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

* Theme-Flatland
* Package Control
* git
* GitGutter

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
