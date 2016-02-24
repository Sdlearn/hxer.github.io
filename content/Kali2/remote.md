---
title: "remote"
date: 2016-01-24 18:52
---

# ssh

## ssh login

```
ssh -l root ip

or

ssh root@ip
```

## ssh-keygen [-f <filename>]

ssh-keygen 生成公钥和私钥文件，将公钥文件的内容，放到远程主机 $HOME/.ssh/authorized_keys 文件中，以后就可以免密码登录

## ssh 长连接设置

* client

```
su
cd /etc/ssh
echo "    ServerAliveInterval 60" >> ssh_config
service ssh restart
exit
```