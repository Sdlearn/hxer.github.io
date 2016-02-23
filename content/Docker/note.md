---
title: "note"
date: 2016-02-19 17:47
---

* docker 思想

每容器只做一件事

* read

[Dockerfile 最佳实践][5]

[10张图带你深入理解Docker容器和镜像][6]

## cmd

### run

* -p

```
run -p <host_port>:<container_port>
e.g. run -p 8000:8000
```


## install docker

* [install][1]

* cmd line

```
# success for debian, ubuntu, kali
curl -sSL https://get.docker.com/ | sh
```

## [ Daocloud ][2]

[docker 简明教程][4]

## [ Docker Hub ][3]

* login

```
docker login
# then input username, email password
```

* push

```
# build
docker build -t username/newimage:tag .

# http://hub.docker.com > Create Repository 
docker push username/newimage
```


```
# 查看环境信息
docker info  
docker version

# 在官方仓库中查找镜像
docker search ubuntu

# 下载获取ubuntu镜像
docker pull ubuntu

# 列出本机拥有的镜像
docker images

# 以交互方式从ubuntu镜像启动容器后运行bash, 并指定容器名称为test
docker run -it --name test ubuntu bash

# 容器停止后自动删除, 测试的时候常用
docker run --rm ubuntu bash

# 容器启动的时候挂载本机workspace目录到容器的根目录下
docker run -it -v ~/workspace:/workspace ubuntu bash

# 以后台进程的方式启动容器
docker run -d ubuntu echo 'hello' > ~/test.txt

# 列出目前运行的容器
docker ps

# 列出最近的容器，包含未正在运行的
docker ps -l

# 挂载一个正在后台运行的容器
docker attach 23ad234

# 列出并追踪容器的运行日志
docker logs -f -t 23ad234

# 暂停运行的容器
docker pause 23ad234

# 恢复暂停的容器
docker unpause 23ad234

# 启动/停止/重启容器(start/stop/restart)
docker start 23ad234

# 显示容器内运行的进程, 每2s刷新一次
docker top 23ad234 -d 2

# 查看容器运行的详细信息
docker inspect 23ad234

# 杀掉正在运行的容器
docker kill 23ad234

# 显示容器文件系统的改动
docker diff 23ad234

# 复制容器中的文件或文件夹到主机系统中
docker cp 23ad234:~/test.txt ./test.txt

# 将容器导出为tar包
docker export 23ad234 > mytest.docker.tar

# 创建一个空容器并导入tar包
docker import ./mytest.docker.tar

# 将容器改动提交到镜像中
docker commit -m mytest 23ad234 ijse/test:mytag

# 列出镜像的历史
docker history ijse/test:mytag

# 登陆官方仓库账户
docker login

# 修改本地镜像名称
docker rename ijse/test ijse/mytest

# 将镜像推送到仓库中
docker push ijse/mytest:mytag

# 删除一个容器 及其关联的数据卷
docker rm -v 23ad234

# 删除一个镜像
docker rmi ubuntu

# 将本机镜像保存为tar包
docker save -o ijse.test.tar ijse/mytest

# 通过Dockerfile来创建一个镜像
docker build ./Dockerfile
```

[1]: https://docs.docker.com/engine/installation/
[2]: https://account.daocloud.io/signup
[3]: https://hub.docker.com/
[4]: http://blog.saymagic.cn/2015/06/01/learning-docker.html
[5]: https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/
[6]: http://dockone.io/article/783