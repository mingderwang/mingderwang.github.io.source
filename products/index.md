---
layout: page
title: 產品介紹
modified: 2015-03-19 17:52
excerpt: "介紹各類軟體之安裝與設定."
image:
  feature: sample-image-3.jpg
  credit: Stella Wang
  creditlink: http://wegraphics.net/downloads/free-ultimate-blurred-background-pack/
---

<section id="table-of-contents" class="toc">
  <header>
    <h3>安裝介紹</h3>
  </header>
<div id="drawer" markdown="1">
* auto gerneate toc
{:toc}
</div>
</section><!-- /#table-of-contents -->

本公司所提供之軟體以開源軟體為主, 我們工程師也投入這些軟體之開發及改良。 平常除了在[技術日誌](/posts/)
與大家分享使用心得以及提供資安及改版等之消息外, 主要安裝及使用等教學文件將會在此頁詳細介紹。


## 本季以 IT 自動化為主
> 提供 **Chef 12** 以及 **Elasticsearch 1.4**, **Logstash**, **Kibana 4.0** (ELK)
等產品之介紹與服務。 其中 Chef 扮演著 IT 自動部署非常重要的角色. 配合 ELK 收集大量系統日誌和資料,
提供更有效率的電腦設備與資源的監控與管理。

> 如此一來, 讓每個公司都能擁有類似安裝 **Splunk** 的系統資訊及時監控與搜尋功能,
雖然 ELK 功能較為簡易, 但在價格上卻是天壤之別。
我們也提供客製化服務, 來適時地增加必要的功能, 以換取公司最佳的 ROI (投資回報率)

---

## 如何使用 Chef 安裝 ELK

基本上 Chef 可以分有主機的 chef-repo 以及沒主機的 chef-solo 兩種, 我們建議公司採用 chef-repo
方式來控管公司所有電腦軟體版本安裝和更新, 進而自動控管使用者帳號和權限部署。

### -- 安裝

第一, 我們先準備一台用來下 knife 指令的工作站, 這裡以ㄧ台裝好 Ubuntu 12.04 或 Mac OS X 筆電為例。
請依照 https://downloads.chef.io/chef-dk/ 指示, 安裝好 ChefSDK, 並將其安裝目錄加至您 PATH
路徑.

### -- 使用

第一, 生成一個新的工作目錄, 這裡稱之為 "chef-repo"。您最好使用 git 版本控管此目錄, 如此一來,
便可以讓其他人或在其他電腦上更新 chef server 內容和修改 cookbooks 和 nodes 等資源.

{% highlight Bash%}
//產生一個新 repo 目錄, 叫 chef-repo
chef generate repo chef-repo
{% endhighlight %}

第二, 自動安裝 chef-client 於 node1 主機

{% highlight Bash%}
$ knife bootstrap node1
{% endhighlight %}

第三, 我們找一台本工作站可以 ssh 的到的電腦, 這裡假設它叫 "node1", 來自動配置 Elasticsearch.

{% highlight Bash%}
cd chef-repo
mkdir nodes
cd nodes
cat > node1.json <<EOL
{ "name": "node1",
"chef_type": "node",
"json_class": "Chef::Node",
"chef_environment": "_default",
"default": {
  },
  "normal": {
    },
    "override": {
      },
      "elasticsearch": {
        "cluster" : { "name" : "elasticsearch_from_chef" }
        },
        "run_list": [
        "recipe[monit]",
        "recipe[java]",
        "recipe[elasticsearch]",
        "recipe[elasticsearch::monit]",
        "recipe[log4-elasticsearch]",
        "recipe[logstash::server]",
        "recipe[chamber-kibana::default]"
        ]
      }
EOL
{% endhighlight %}

以及利用如下指令, 將 node1 的 runlist 更新到 chef server 上

{% highlight Bash%}
$ knife node from file node1.json
{% endhighlight %}

最後, 到 node1 主機上, 手動更新 run list, 就會自動安裝 Elasticsearch, Logstash, 以及 Kibana

{% highlight Bash%}
$ chef-client
{% endhighlight %}

---

### -- 技巧

1. 這裡還包含安裝 monit, 是利用 monit 來確保 Elasticsearch 的不停頓運轉。

---

### 客製化服務

* 我們可以幫客戶製作客製化 cookbooks
* 我們可以規劃其他軟體自動化部屬
* 有問題請寄電子郵件到: <a href="mailto:support@log4analytics.com">support@log4analytics.com

---

### 版權所有

* Splunk is a product and trademark of Splunk Inc.
* Elasticsearch, Logstash & Kibana are trademarks of Elasticsearch BV.
* Chef and Open Source Chef is a trademark of Chef Software, Inc.
