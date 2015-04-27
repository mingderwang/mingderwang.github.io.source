---
layout: post
title: 利用 SIEM 做好最基本的個資保護以及資安管理
tagline: siem solutions
tags: devops mis siem
category: ming
author: ming
date: 2015-04-27 14:02
---
明天一年ㄧ度的國際安全博覽會Secutech,又要在台北南港展覽館隆重登場. 但大部分的人對於安全
焦點都聚集在實體安全, 卻忽略了看不見的網路安全, 資訊安全這一塊. 其實雖然新的個資法早在
2012年10月1日已經上路, 到底有多少人願意花更多軟硬體設備來保護公司機密資料, 以及主動
保護客戶資料不被盜取. 我們來分析到底有哪些最基本的保護動作我們可以利用 SIEM
或硬體防護牆來保護公司的電腦不被入侵. 這裡我們先針對 SIEM 來討論.

>


什麼是[SIEM 軟體?](http://www.ithome.com.tw/node/77205) 這個連結引述 IThome
已經介紹不少log管理及報表軟體, SIEM 就是 Security Information and Event Management.
的縮寫. 簡單講就是利用事件(或所謂的系統的logs)的有效管理, 來解決資安的問題.

>

2012年絕大部份這類軟體還是著重於 log 的收集與報表的產生.但三年後的今天,根據2014年
Gartnar
對所有175家SIEM軟體公司所做的MQ圖的分析結果來看, 具有領導指標的幾家廠商都開始著重及時查詢與自動反應.
甚至於未來可能導入人工智慧 (這是我說的), 來做更準確的預測, 做最適當的防堵, 以降低被入侵的風險.

>

老實說, Gartner的分析師也說

---
>> “The greatest area of unmet need is effective targeted attack and breach detection. Organizations are failing at early breach detection, with more than 92% of breaches undetected by the breached organization. The situation can be improved with stronger threat intelligence, the addition of behavior profiling and better analytics. Most companies expand their initial SIEM deployments over a three-year period to include more event sources and greater use of real-time monitoring.”

---
目前最大的問題, 還是在是否能有效的偵測到目標性攻擊以及找到弱點. 有92%被入侵的公司或單位
都無法在初期弱點偵測發現問題. 這些問題必須用更好的分析能力以及更聰明的方法來解決入侵的
問題. 所有公司在未來三年內都期望能有更即時監控與事件資料能結合的 SIEM 來使用.

>

但如果能做最基本的 log 集中管理, 安裝簡單的入侵事件收集 agents, 平時監控到底有多少
IP嘗試的對你公司電腦做攻擊, 當你發現有此現象, 就應該做更嚴格的密碼把關, 架設更高的層次
的防火牆安全措施. 如果沒有即時監控, 就像平時不做健康檢查, 也不量血壓是一樣的危險.

>

我們希望能結合類似 splunk 能即時查詢IT資料的 Elasticsearch 軟體與[IBM X-force
Exchange](https://exchange.xforce.ibmcloud.com/) 智慧型資安即時資訊, 來協助您防衛貴單位或公司的電腦和網路, 盡量能保護公司
多年來累積的智慧資產以及客戶資料, 避免外洩. 有興趣合作的客戶或廠商, 都可以與我們聯絡.


>

##聯絡我們:
---------------------

請用[電子郵件 sales@log4analytics.com](mailto:support@log4analytics.com)或電話 0910-006-662(王先生)聯絡,
安排展示時間或安裝監控及查詢軟體.

>

桐立科技, Log4 Analytics 團隊
