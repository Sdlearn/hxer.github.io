## requests

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