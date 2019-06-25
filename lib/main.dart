import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/login/login_page.dart';
import 'pages/main/main_page.dart';
import 'pages/main/main_state.dart';
import 'pages/my/my_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "大神留条命",
      routes: <String, WidgetBuilder>{
        '/my': (BuildContext context) => MyPage(),
        '/login': (BuildContext context) => LoginPage(),
      },
      home: ChangeNotifierProvider<MainState>(
        builder: (_) => MainState(),
        child: MainPage(),
      ),
    );
  }
}
