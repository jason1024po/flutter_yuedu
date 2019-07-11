package com.iwubida.flutter_yuedu;

import android.os.Bundle;

import com.iwubida.flutter_yuedu.plugins.UpdateVersionPlugin;

import org.devio.flutter.splashscreen.SplashScreen;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    SplashScreen.show(this, true);
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    // 注册更新组件
    UpdateVersionPlugin.registerWith(registrarFor("iwubida.com/update_version"));

  }
}
