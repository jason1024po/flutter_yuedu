import 'package:flutter/material.dart';

/// appbar 返回按钮类型
enum AppBarBackType { Back, Close }

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
