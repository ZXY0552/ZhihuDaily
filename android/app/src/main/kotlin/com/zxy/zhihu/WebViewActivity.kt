package com.zxy.zhihu

import android.app.Activity
import android.os.Bundle
import android.text.TextUtils
import android.widget.TextView
import io.flutter.plugin.common.MethodChannel
import org.w3c.dom.Text

/**
 * @author zxy
 * @date  2020/7/4
 * Describe:
 */
class WebViewActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.webview_layout)
        val newsId = intent.getStringExtra("newsId")
        if (!TextUtils.isEmpty(newsId)) {
            MethodChannelPlugin.newInstance().invokeMethod(newsId, object : MethodChannel.Result {
                override fun success(o: Any?) {
                    findViewById<TextView>(R.id.tv).text = o.toString()
                }

                override fun error(s: String, s1: String?, o: Any?) {}
                override fun notImplemented() {}
            })
        }
    }

}