package com.zxy.zhihu

import android.annotation.SuppressLint
import android.app.Activity
import android.os.Bundle
import android.text.TextUtils
import android.webkit.WebChromeClient
import android.webkit.WebView
import io.flutter.plugin.common.MethodChannel

/**
 * @author zxy
 * @date  2020/7/4
 * Describe:
 */
class WebViewActivity : Activity() {
    lateinit var webView: WebView

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.webview_layout)
        webView = findViewById(R.id.webView)
        webView.settings.javaScriptEnabled = true
        webView.webChromeClient = WebChromeClient()
        val newsId = intent.getStringExtra("newsId")
        if (!TextUtils.isEmpty(newsId)) {
            MethodChannelPlugin.newInstance().invokeMethod("getNewsDetails", newsId, object : MethodChannel.Result {
                override fun success(o: Any?) {
                    webView.loadData(o.toString(), "text/html", "UTF-8")
                }

                override fun error(s: String, s1: String?, o: Any?) {}
                override fun notImplemented() {}
            })
        }
    }

}