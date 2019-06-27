import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyNavigator {
  // push 新页面
  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  // iOS 从底部向上出来的页面
  static present(BuildContext context, Widget page) {
    Navigator.of(context).push(
        MaterialPageRoute(fullscreenDialog: true, builder: (context) => page));
  }
}
