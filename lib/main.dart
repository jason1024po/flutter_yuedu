import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'pages/book/book_list_provider.dart';
import 'pages/home/home_provider.dart';
import 'pages/main/main_page.dart';
import 'pages/main/main_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MainProvider>.value(value: MainProvider()),
      ChangeNotifierProvider<HomeProvider>.value(value: HomeProvider()),
      ChangeNotifierProvider<BookListProvider>.value(value: BookListProvider()),
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
      home: OKToast(
        radius: 4,
        textPadding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
        child: MainPage(),
      ),
    );
  }
}
