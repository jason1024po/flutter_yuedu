import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home/home_provider.dart';
import 'pages/main/main_page.dart';
import 'pages/main/main_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MainProvider>.value(value: MainProvider()),
      ChangeNotifierProvider<HomeProvider>.value(value: HomeProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "大神留条命",
      home: MainPage(),
    );
  }
}
