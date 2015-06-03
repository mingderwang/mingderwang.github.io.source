---
layout: post
title: 如何用 logstash 收集 rsyslog 的資料
tagline: rsyslog+logstash
tags: datacenter devops mis lem slunk
category: ming
author: ming
date: 2015-06-02 15:14
---

提到電腦管理, 很多公司為了符合ISO, 都有規定將重要電腦的系統日誌收集起來, 方便事後查詢.
但傳統 MIS 系統管理者, 往往需要花大筆的時間和金錢來收集或甚至於分析這些資料. 這對小公司來說,
在人力及經費吃緊的情況下, 這可能是一筆沈重的負擔. 這裡, 我們為中小企業尋求一個簡單又便宜得方法,
又能同時收集 windows 或 linux 電腦的系統訊息和事件日誌, 也能同收集應用程式的日誌,
例如 php Apache 或 nginx 等網頁日誌, 系統與網路資安相關日誌, 還有硬體防火牆等相關設備的日誌.
當您可以集中收集時, 意味著您也能, 即時查詢 (方便管理者或售後服務解決問題), 未來更能夠利用 big data
或所謂的機器學習 (人工智慧的一種技術) 來分析這些資料之間的關係, 即時提供視覺化結果, 當成決策者判斷的依據.

>

這裡先介紹 [rsyslog](http://www.rsyslog.com/), 它可以快速且安全的收集各種系統日誌, 將它送到你指定的地方,
集中管理你想要追蹤的資訊. 速度甚至在本機可以同時分發高達每秒一百萬筆的訊息. 因為其高度模組化,
以及輸出格式的高度彈性, 因此能依每家公司的需求進行客製化. 輸出可到各種資料庫 MySQL, PostgreSQL,
Oracle, 或 MongoDB, 甚至於是 Eliasticsearh 或 Hadoop 的檔案格式 hdfs. 如果怕資料來不及接收,
也能經過各種 Queues, 例如 redis, zmq3 等來當緩衝.

>

如果你是 Linux 作業系統, 當安裝 rsyslog 之後, 你可以在兩個地方做設定, 一個是跟 rsyslog 比較直接相關的東西,
可以定義在 /etc/rsyslog.conf 檔案裡, 其他若要做個別不同方法或應用的設定, 可以在 /etc/rsyslog.d
目錄下, 提每個功能個別定義一個 config 檔, 因為在 /etc/rsyslog.conf 的最後一行, 會把其他 config 檔讀進來(如下).

{% highlight Bash%}
#
# Include all config files in /etc/rsyslog.d/
#
$IncludeConfig /etc/rsyslog.d/*.conf
{% endhighlight %}

所以我們可以多加一個新設定 rsyslogd.conf 在 /etc/rsyslog.d/ 目錄下, 其內容如下

{% highlight Bash%}
## rsyslogd.conf
$ModLoad immark.so
$ModLoad imuxsock.so
$ModLoad imklog.so
$ModLoad imudp
# You only need $UDPServerRun if you want your syslog to be a centralized server.
$UDPServerRun 514
$AllowedSender UDP, 127.0.0.1, [::1]/128

$template ls_json,"\{\%timestamp:::date-rfc3339,jsonf:@timestamp%,%source:::jsonf:@source_host%,\"@source\":\"syslog://%fromhost-ip:::json%\",\"@message\":\"%timestamp% %app-name%:%msg:::json%\",\"@fields\":\{\%syslogfacility-text:::jsonf:facility%,%syslogseverity-text:::jsonf:severity%,%app-name:::jsonf:program%,%procid:::jsonf:processid%}}"

*.*  @localhost:55514;ls_json
{% endhighlight %}


內容表示 rsyslog 會以 ls_json 定義的格式, 將資料送到本機 localhost 的 55514 port.
本機在裝個 [logstash](https://www.elastic.co/products/logstash) 在 55514 port,
將內容轉送到 [elasticsearch](https://www.elastic.co/products/elasticsearch) server 只要加一個 logstash
設定如下:

{% highlight Bash%}
input {
  udp {
    port => 55514
    type => "rsyslog"
    buffer_size => 8192
    format => "json_event"
  }
}
output {
  elasticsearch {
    host => "localhost"
    protocol => "http"
  }
  #stdout { codec => rubydebug }
}
{% endhighlight %}

以上 logstash 設定檔, logstash_rsyslog.conf, 可以放在 /opt/logstash/server/etc/conf.d
目錄下, 再重啟 logstash_server 即可.

{% highlight Bash%}
$ sudo service logstash_server restart
{% endhighlight %}
>

當然要新增或維護多台或甚至上百台電腦的 config 檔時, 若不採用任何像 chef, puppet, ansible,
或 salt 等自動化部屬工具, 對系統管理者來說, 將會是一個很頭痛的問題.
以上只是用手動先試試看, 設定檔的功能是否如我們所預期. 以 chef 為例, 再來就需要修改 cookbook,
讓 chef 自動安裝 rsyslog 及 logstash 到每一台電腦, 並且自動產生或修改必要的 config 檔.
如此一來, 也替未來的任何修改或補丁, 做好了萬全的準備.

>

##聯絡我們:
---------------------

請用[電子郵件 hello@log4analytics.com](mailto:hello@log4analytics.com)或電話 0910-006-662(王先生)聯絡,
安排展示時間或安裝監控及查詢軟體.

>

桐立科技, Log4 Analytics 團隊
