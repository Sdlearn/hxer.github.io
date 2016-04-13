---
title: "ELK"
date: 2016-04-11 21:08
---

## 简介

* ElasticSearch

Elasticsearch是一个基于Apache Lucene(TM)的开源的实时分布式搜索和分析引擎,可以快速处理大数据，用于全文搜索、结构化搜索、分析以及将这三者混合使用。

[Elasticsearch download][1]

[Elasticsearch install and running][2]

* Logstash

[logstash download][6]
[logstash document][7]

* Kibana

[kibana download][4]

[kibana install and running][5]

download tar.gz and extract

```
cd kibana-4.5.0-linux-x64/bin
./kibana 

# browser
http://localhost:5601/app/kibana
```


install and run app sense

```
cd kibana-4.5.0-linux-x64/bin
./kibana plugin --install elastic/sense
./bin/kibana
```

Open Sense your web browser by going to http://localhost:5601/app/sense






[1]: https://www.elastic.co/downloads/elasticsearch
[2]: https://www.elastic.co/guide/en/elasticsearch/reference/current/_installation.html

[4]: https://www.elastic.co/downloads/kibana
[5]: https://www.elastic.co/guide/en/kibana/current/setup.html

[6]: https://www.elastic.co/downloads/logstash
[7]: https://www.elastic.co/guide/en/logstash/current/index.html