# requests

## requests proxy

* socks proxy

install: `pip install -U requests[socks]`

usage:

```python
import requests

resp = requests.get('http://go.to',
                    proxies=dict(http='socks5://user:pass@host:port',
                                 https='socks5://user:pass@host:port'))

resp = requests.get('http://go.to',
                    proxies=dict(http='socks4://user:pass@host:port',
                                 https='socks4://user:pass@host:port'))
```

### `requests proxy` vs `pysocks proxy`

[pysocks](https://github.com/Anorov/PySocks)

* http proxy

pysocks 进行 http 代理时， 使用的是 HTTP CONNECT 方式， 对于不支持 `CONNECT` 方式的代理服务器，比如BurpSuite, 就无效

requests 进行 http 代理，不使用 HTTP CONNECT 方式， 兼容性更好

## error

* 常见报错解析

```
[Errno 8] Failed to establish a new connection: [Errno 8] nodename nor servname provided, or not known',))
[Errno -5] No address associated with hostname
[Errno -2] Name or service not known
-- DNS lookup of the host name you're trying to access failed
```
