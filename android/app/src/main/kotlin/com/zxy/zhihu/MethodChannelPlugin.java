package com.zxy.zhihu;

import android.content.Context;
import android.os.Bundle;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.List;

import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;

/**
 * @author zxy
 * @date 2020/7/5
 * Describe:
 */
class MethodChannelPlugin implements MethodChannel.MethodCallHandler {
    private volatile static MethodChannelPlugin plugin;
    private MethodChannel methodChannel;

    public static MethodChannelPlugin newInstance() {
        if (plugin == null) {
            synchronized (MethodChannelPlugin.class) {
                if (plugin == null) {
                    plugin = new MethodChannelPlugin();
                }
            }
        }
        return plugin;
    }


    public void register(@NonNull MethodChannelRegistryConfig channelRegistryConfig) {
        methodChannel = new MethodChannel(channelRegistryConfig.getFlutterView(), channelRegistryConfig.getChannel());
        methodChannel.setMethodCallHandler(this);
    }

    public void unregister(@NonNull MethodChannelRegistryConfig channelRegistryConfig) {
        methodChannel = null;
    }

    public void invokeMethod(@NonNull String method, MethodChannel.Result result) {
        methodChannel.invokeMethod(method, null, result);
    }

    public void invokeMethod(@NonNull String method, Object arguments, MethodChannel.Result result) {
        methodChannel.invokeMethod(method, arguments, result);
    }


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Log.e("zxy", call.method + " " + call.arguments);
    }

    public interface MethodChannelRegistryConfig {
        FlutterView getFlutterView();

        Context getContext();

        void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result);

        String getChannel();
    }
}
