package com.zxy.zhihu

import android.content.Context
import android.content.Intent
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity(), MethodChannelPlugin.MethodChannelRegistryConfig {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        MethodChannelPlugin.newInstance().register(this)
    }

    override fun getContext(): Context {
        return this
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "openNewsDetails") {
            val intent = Intent(this, WebViewActivity::class.java)
            intent.putExtra("newsId", call.arguments.toString())
            startActivity(intent)
        }
    }

    override fun getChannel(): String {
        return "zhihu.flutter.io/newsDetails";
    }
}
