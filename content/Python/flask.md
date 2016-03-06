---
title: "Flask"
date: 2016-03-02 10:08
---


## 参考资源

* [FLASK使用小结][1]
* [flask api][2]

[1]: http://www.wklken.me/posts/2013/09/09/python-framework-flask.html
[2]: http://flask.pocoo.org/docs/0.10/api/

## note

* return a requests response object

```
@app.route('/')
def index():
    url = 'xxx'
    resp = requests.get(url)
    return (resp.content, resp.status_code, resp.headers.items())
```