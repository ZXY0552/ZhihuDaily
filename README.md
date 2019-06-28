# Flutter版高仿知乎日报

高仿知乎日报，UI基本和Android端的知乎日报一致。新手小白的练习demo，代码十分简单。

[API来源](https://github.com/izzyleung/ZhihuDailyPurify/wiki/%E7%9F%A5%E4%B9%8E%E6%97%A5%E6%8A%A5-API-%E5%88%86%E6%9E%90)

## 截图

![](screenshot/Jun-28-201911-07-46.gif)
![](https://github.com/ZXY0552/ZhihuDaily/screenshot/SimulatorScreenShot1.png)![](https://github.com/ZXY0552/ZhihuDaily/screenshot/SimulatorScreenShot2.png)![](https://github.com/ZXY0552/ZhihuDaily/screenshot/SimulatorScreenShot3.png)
![](https://github.com/ZXY0552/ZhihuDaily/screenshot/SimulatorScreenShot4.png)![](https://github.com/ZXY0552/ZhihuDaily/screenshot/SimulatorScreenShot5.png)![](https://github.com/ZXY0552/ZhihuDaily/screenshot/SimulatorScreenShot6.png)
![](https://github.com/ZXY0552/ZhihuDaily/screenshot/SimulatorScreenShot7.png)![](https://github.com/ZXY0552/ZhihuDaily/screenshot/SimulatorScreenShot8.png)![](https://github.com/ZXY0552/ZhihuDaily/screenshot/SimulatorScreenShot9.png)
![](https://github.com/ZXY0552/ZhihuDaily/screenshot/SimulatorScreenShot10.png)![](https://github.com/ZXY0552/ZhihuDaily/screenshot/SimulatorScreenShot11.png)![](https://github.com/ZXY0552/ZhihuDaily/screenshot/SimulatorScreenShot12.png)

## 实现功能

* 基本数据展示。
* 本地添加收藏和收藏列表。
* 评论列表，只能展示无法评论。
* 夜间模式。
* 本地数据缓存，网络请求失败的情况下会加载已经缓存的数据。
* 专栏新闻列表。

## 未完成

* 离线下载（查看过的能离线缓存，但不能主动点离线下载缓存数据）。
* 设置页面（无图模式，清除缓存，大号字等）。
* 新闻列表阅读记录，看过的标题变色。
* 还有一些受接口限制无法完成的比如专栏、账号相关（登录、点赞、评论，通知，推送）。
* 启动页面，启动图接口无数据返回也没有写。
* 界面很多细节可以还以优化，iOS、Android不同平台之间UI的本地化。

# 使用的库

* [json_annotation](https://pub.dev/packages/json_annotation) JSON序列化
* [fluttertoast](https://pub.dev/packages/fluttertoast) toast
* [flutter_swiper](https://pub.dev/packages/flutter_swiper) 轮播图
* [dio](https://pub.dev/packages/dio) 网络请求框架
* [flutter_inappbrowser](https://pub.dev/packages/flutter_inappbrowser) webview
* [share](https://pub.dev/packages/share) 分享
* [shared_preferences](https://pub.dev/packages/shared_preferences) 本地数据缓存
* [cached_network_image](https://pub.dev/packages/cached_network_image) 图片缓存加载
* [scoped_model](https://pub.dev/packages/scoped_model) 数据传递
* [sqflite](https://pub.dev/packages/sqflite) 本地sqlite