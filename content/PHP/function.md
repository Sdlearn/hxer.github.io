---
title: "Function"
date: 2016-04-22 23:49
---

## file

### is_file

> bool is_file ( string $filename )

判断给定文件名是否为一个正常的文件。

```
参数 

filename: 文件的路径
```

* 测试环境

```
路径
/var/www/
    123/
        test.php
        45/
            robot.txt
```

test.php 

```
// test.php
<?php
$file = $_GET['file'];

if (is_file($file)){
    echo "exist";
}else{
    echo "not exist";
}
?>
```

```
http://localhost/123/test.php?file=test.php --> exitst

/123/test.php --> not exitst
/test.php --> not exitst
./test.php --> exitst
45/../test.php --> exitst
46/../test.php --> not exist
```

从上面结果可以猜测出， is_file 判断文件是否存在时，文件路径为 该php文件的路径 + 带路径的参数$filename，并且当某个目录不存在时，返回false

```
# 跟路径 /var/www/

test.php -> 123/ + test.php = 123/test.php --> exist
/123/test.php -> 123/123/test.php --> not exitst
/test.php 123//test.php --> not exitst
./test.php 123/./test.php --> exitst
45/../test.php -> 123/45/../test.php --> exitst
46/../test.php -> 123/46/../test.php --> not exist
```

当 46 文件夹不存在时, is_file返回的是false, 这个特性可以用作 ** php 文件的过滤绕过 **

另外， is_file存在缓存机制，第一次调用is_file函数的时候，PHP会把文件的属性（file stat）保存下来，当再次调用is_file的时候，如果文件名更第一次的一样，那么就会直接返回缓存，即使文件已经删除了。
