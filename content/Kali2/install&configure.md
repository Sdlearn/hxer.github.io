---
title: "install and configure"
date: 2016-01-20 21:20
---

## 更新源

vim /etc/apt/sources.list

```
#中科大源
deb http://mirrors.ustc.edu.cn/kali sana main non-free contrib 
deb-src http://mirrors.ustc.edu.cn/kali sana main non-free contrib 
deb http://mirrors.ustc.edu.cn/kali-security/ sana/updates main contrib non-free 
deb-src http://mirrors.ustc.edu.cn/kali-security/ sana/updates main contrib non-free
#阿里云kali源
deb http://mirrors.aliyun.com/kali sana main non-free contrib
deb http://mirrors.aliyun.com/kali-security/ sana/updates main contrib non-free
deb-src http://mirrors.aliyun.com/kali-security/ sana/updates main contrib non-free
```

## 安装输入法

```
apt-get install fcitx fcitx-googlepinyin
```

配置：应用程序>常用程序>系统工具>首选项>Fcitx配置 添加拼音

重启或用户注销

## 安装vpn

```
apt-get install -y network-manager-openvpn-gnome network-manager-pptp network-manager-pptp-gnome network-manager-vpnc network-manager-vpnc-gnome
```

## 安装火狐
```
apt-get remove iceweasel
echo -e "\ndeb http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt all main" | tee -a /etc/apt/sources.list > /dev/null
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com C1289A29
apt-get update
apt-get install firefox-mozilla-build
```
## 安装Chromium

```
sudo apt-get isntall chromium
```

## 新增用户

```
useradd -m username
passwd username
usermod -a -G sudo username
chsh -s /bin/bash username
id username         #查看配置
```

## 开启SSH服务

```
#vi /etc/ssh/sshd_config   
```
将#PasswordAuthentication no的注释去掉，并且将NO修改为YES
将#PermitRootLogin yes的注释去掉

启动SSH服务

```
#/etc/init.d/ssh start    //or service ssh start
```

验证SSH服务状态

```
#/etc/init.d/ssh status
```

开机自启动

```
# vi /etc/init.d/rc.local
#service ssh start  // add for sshd autorun
```

## proxy

* socks proxy

1.安装

```
$ pip install proxychains
```

2.编辑proxychains配置

```
$ vim /etc/proxychains.conf
```

3.将socks4 127.0.0.1 9095改为

> socks5 127.0.0.1 1080

ps: 默认的socks4 127.0.0.1 9095是tor代理，而socks5 127.0.0.1 1080是shadowsocks的代理

4.使用方法

在需要代理的命令前加上 proxychains ，如：

```
$ sudo proxychains apt-get update
```

## ftp

* vsftp

install

```
$apt-get install vsftpd
```

config

```
$vim /etc/vsftpd.conf
    Write_enable=YES 将前面的#去掉
    chroot_local_user=YES 将前面的#去掉
$mkdir /home/hx/ftp
$chmod -R 777 ftp
$chmod a-w ftp
$sudo useradd -g ftp -d /home/hx/ftp/ <user>
$sudo passwd <user>
$sudo service vsftpd restart
```


## web环境(LAMP)配置

1.apache 服务启动     
```
sudo service apache2 start
```

2.修改网站默认打开路径 

    /etc/apache2/sites-enabled/000-default.conf    
            修改“DocumentRoot /var/www/html" to "DocumentRoot yourpath"     这是修改80端口
    /etc/apache2/sites-available/default*
            修改“DocumentRoot /var/www/html" to "DocumentRoot yourpath"     这是修改443端口（可选）
    /etc/apache2/apache2.conf
            增加如下内容--进入权限
            <Directory yourpath>
                Options Indexes FollowSymLinks
                AllowOverride None
                Require all granted
            </Directory>
                 
2.mysql 服务启动        
```
sudo service mysql start
```

3.php 配置      

直接在/var/www/html/(默认情况)目录放php文件，即可通过 http://127.0.0.1/xx.php 来访问 
修改php.ini文件， 改为"display_errors = On"     重启apache生效

4.织梦模板

下载织梦源码包，解压，按要求操作！
a.安装GD扩展库：     
```
apt-get install php5-gd
```
b.php.ini(/etc/php5/apache2/php.ini) 找到 ”[gd]“， 在该区域下增加一行”extension=gd.so“

## funny tool

* 1.fuck

install

```
$ wget -O - https://raw.githubusercontent.com/nvbn/thefuck/master/install.sh | sh - && $0
```

use

```
$ fuck
```

## 命令行锁屏

```
# apt-get install gnome-screensaver
$ gnome-screensaver-command -l     #lock
$ gnome-screensaver-command -a     #active
```


## 系统设置

* 终端快捷键

设置>键盘>快捷键>自定义快捷键

名称：终端
命令：gnome-terminal

添加后，单击那一行，按下 ctrl+alt+T

* 设置屏幕刷新率

```
$xrandr -r 60
```

## vmware

1. Install linux-headers-$(uname -r)
```
apt-get install linux-headers-$(uname -r)
```

2. Download and Install VMWare as normal

3. Patch for Kernel 4.0

```
$ curl http://pastie.org/pastes/9934018/download -o /tmp/vmnet-3.19.patch
Extract the vmnet module sources:
$ cd /usr/lib/vmware/modules/source


# tar -xf vmnet.tar
Apply the patch:
# patch -p0 -i /tmp/vmnet-3.19.patch
Recreate the archive:
# tar -cf vmnet.tar vmnet-only
Remove leftover:
# rm -r -only
Rebuild modules:
# vmware-modconfig --console --install-all

Fix network vitural not complie
# - as root user
$ cd /usr/lib/vmware/modules/source
$ tar -xvf vmnet.tar
# - edit the file vmnet-only/netif.c and replace the line that looks like
dev = allocnetdev(sizeof netIf, deviceName, VNetNetIfSetup);
to
dev = allocnetdev(sizeof netIf, deviceName, NETNAMEUNKNOWN, VNetNetIfSetup);
$ tar -cvf vmnet.tar vmnet-only/
$ rm -rf vmnet-only/
```

key：1A2ZZ-8RH06-AZTJ1-7A17H-32RM8


## webgoat

* 快速使用

    + 已安装java的条件下，根据github上说明进行安装，下载"*jar"文件

    ```
    https://github.com/WebGoat/WebGoat-Legacy/releases
    ```

    + run

    ```
    java -jar WebGoat-6.0.1-war.exec.jar". 
    ```
    
    + browse 
    
    ```
     http://localhost:8080/WebGoat
    ```
    
* 安装源码（for developers）

    + 下载source文件
    + 下载JAVA JDK，满足安装要求的版本，Kali自带java jdk且满足要求
    + 下载配置maven， http://maven.apache.org/  
    
    按要求下载 apache-maven-3.2.3-bin.tar.gz    
    
    下载文件解压至/usr/local/目录下
        
    vi /etc/profile 设置全局变量
    
    ```
            M2_HOME=/usr/local/apache-maven-3.2.3 
            export M2_HOME 
            PATH=$PATH:$M2_HOME/bin 
            export PATH
    ```
    
    ```
    #source /etc/profile  生效
    ```
    
    测试是否成功
    
    ```
    #mvn -v
    ``` 
    
    + maven 修建项目
    
    ```
    #cd webgoat* #(webgoat 源码解压目录),
    #mvn clean package
    #mvn tomcat:run-war
    ```
    
    + 选用eclipse，安装maven插件，
    
    name为：m2e, 
    
    location为：http://download.eclipse.org/technology/m2e/releases
    
    当这样安装插件时会报错，原因是m2e插件和eclipse版本不匹配导致，location改为：http://download.eclipse.org/technology/m2e/releases/1.4 即可。