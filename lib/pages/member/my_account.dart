import 'package:flutter/material.dart';
import 'package:flutter_yuedu/widget/my_app_bar.dart';
import 'package:flutter_yuedu/widget/nav_large_title.dart';

class MyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffefefe),
      appBar: MyAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: <Widget>[NavLargeTitle("我的帐户")],
      ),
    );
  }
}
