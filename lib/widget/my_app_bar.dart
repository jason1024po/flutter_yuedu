import 'package:flutter/material.dart';

/// appbar 返回按钮类型
enum AppBarBackType { Back, Close }

// 自定义 AppBar
class MyAppBar extends AppBar with PreferredSizeWidget {
  @override
  get preferredSize => Size.fromHeight(44);
  MyAppBar(
      {Key key,
      Widget title,
      AppBarBackType leadingType,
      Widget leading,
      Brightness brightness,
      Color backgroundColor,
      List<Widget> actions,
      double elevation})
      : super(
          key: key,
          title: title,
          brightness: brightness ?? Brightness.light,
          backgroundColor: backgroundColor ?? Color(0xfffefefe),
          leading: leading ?? AppBarBack(leadingType ?? AppBarBackType.Back),
          actions: actions,
          elevation: elevation ?? 0,
        );
}

// 自定义返回按钮
class AppBarBack extends StatelessWidget {
  final AppBarBackType _backType;

  AppBarBack([this._backType]);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: _backType == AppBarBackType.Close
          ? Image.asset("images/main/parentveri_close.png")
          : Image.asset("images/main/btn_back_normal.png"),
    );
  }
}
