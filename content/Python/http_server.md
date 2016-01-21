---
title: "http_server"
date: 2016-01-20 05:33
---

# run a simple http server

* 命令行运行

```
cd ~/www    #切换到你想在浏览器上访问的目录
python -m SimpleHTTPServer [<port>] #默认端口8000
```

访问

```
http://127.0.0.1:8000/index.html
http://your_ip:8000/index.html
```

# wsgi

WSGI provides a minimal interface between Python Web servers and Python Web Frameworks. It’s very simple and it’s easy to implement on both the server and the framework side. The following code snippet shows the server and the framework side of the interface:

```python
def run_application(application):
    """Server code."""
    # This is where an application/framework stores
    # an HTTP status and HTTP response headers for the server
    # to transmit to the client
    headers_set = []
    # Environment dictionary with WSGI/CGI variables
    environ = {}

    def start_response(status, response_headers, exc_info=None):
        headers_set[:] = [status, response_headers]

    # Server invokes the ‘application' callable and gets back the
    # response body
    result = application(environ, start_response)
    # Server builds an HTTP response and transmits it to the client
    …

def app(environ, start_response):
    """A barebones WSGI app."""
    start_response('200 OK', [('Content-Type', 'text/plain')])
    return ['Hello world!']

run_application(app)
```

Here is how it works:

* The framework provides an ‘application’ callable (The WSGI specification doesn’t prescribe how that should be implemented)

* The server invokes the ‘application’ callable for each request it receives from an HTTP client. It passes a dictionary ‘environ’ containing WSGI/CGI variables and a ‘start_response’ callable as arguments to the ‘application’ callable.

* The framework/application generates an HTTP status and HTTP response headers and passes them to the ‘start_response’ callable for the server to store them. The framework/application also returns a response body.

* The server combines the status, the response headers, and the response body into an HTTP response and transmits it to the client
