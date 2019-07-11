package com.iwubida.flutter_yuedu.plugins;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.util.Log;


import androidx.annotation.NonNull;

import com.azhon.appupdate.config.UpdateConfiguration;
import com.azhon.appupdate.listener.OnDownloadListener;
import com.azhon.appupdate.manager.DownloadManager;
import com.iwubida.flutter_yuedu.R;


import java.io.File;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.EventChannel;

import io.flutter.plugin.common.PluginRegistry.Registrar;

/** UpdateVersionPlugin */
public class UpdateVersionPlugin implements EventChannel.StreamHandler {


  private  static String TAG = "MYUPDATE";

  private final Context context;

  // 上次进度
  static int lastPercent = 0;

  // 下载管理
  DownloadManager manager;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final EventChannel channel = new EventChannel(registrar.messenger(), "plugins.iwubida.com/update_version");
    channel.setStreamHandler(new UpdateVersionPlugin(registrar.context()));
  }

  public UpdateVersionPlugin(Context context) {
    this.context = context;
    setupDownload();
  }

  private void setupDownload() {
    manager = DownloadManager.getInstance(context);
    // 下载配置
    UpdateConfiguration configuration = new UpdateConfiguration();
    configuration.setShowBgdToast(false);

    manager.setApkName(getUpdatePackageName(context))
            .setSmallIcon(R.mipmap.ic_launcher)
            //可设置，可不设置
            .setConfiguration(configuration);
  }


  @Override
  public void onListen(Object o, EventChannel.EventSink eventSink) {

    if (o.toString().length() < 5) {
      eventSink.error(TAG, "URL错误", o);
      return;
    }
    if (!o.toString().startsWith("http")){
      eventSink.error(TAG, "URL错误", o);
    }

    manager.setApkUrl(o.toString());

    manager.getConfiguration().setOnDownloadListener(new OnDownloadListener() {
      Map data = new HashMap<String, Object>();

      @Override
      public void start() {
        data.put("start", true);
        data.put("cancel", true);
        data.put("done", true);
        data.put("error", false);
        data.put("percent", 0);
        eventSink.success(data);
      }

      @Override
      public void downloading(int max, int progress) {
        // 下载进度
        int percent = (int)(progress * 1.0 / max * 100);
        // 限制消息发送
        if (lastPercent != percent && percent > 0) {
          data.put("percent", percent);
          eventSink.success(data);
        }
        lastPercent = percent;
      }

      @Override
      public void done(File apk) {
        data.put("done", true);
        eventSink.success(data);
      }

      @Override
      public void cancel() {
        data.put("cancel", true);
        eventSink.success(data);
      }

      @Override
      public void error(Exception e) {
        data.put("error", e.toString());
        eventSink.success(data);
      }
    });
    manager.download();
  }

  @Override
  public void onCancel(Object o) {
    Log.i(TAG, "取消下载1111");
    manager.cancel();
  }


  // 获取包名
  public static String getUpdatePackageName(@NonNull Context context) {
    String packageName = "update_app.apk";
    try {
      PackageInfo info = context.getPackageManager().getPackageInfo(context.getPackageName(), 0);
      packageName = info.packageName + ".apk";
    } catch (PackageManager.NameNotFoundException e) {
      e.printStackTrace();
    }
    return packageName;
  }

}
