import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutter_yuedu/pages/bookshelf/book_shelf_page.dart';
import 'package:flutter_yuedu/pages/course/course_page.dart';
import 'package:flutter_yuedu/pages/home/home_page.dart';
import 'package:flutter_yuedu/pages/my/my_page.dart';
import 'package:provider/provider.dart';

import 'main_provider.dart';
import 'my_bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // PageController
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      FlutterSplashScreen.hide(); // 隐藏启动屏
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainState = Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xfffefefe),
      bottomNavigationBar: MyBottomNavigationBar(onTap: (index) {
        _controller.jumpToPage(index);
        setState(() {
          mainState.setTabBarSelectedIndex = index;
        });
      }),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          CoursePage(
            url: mainState.courseUrl,
          ),
          BookShelfPage(),
          MyPage(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
