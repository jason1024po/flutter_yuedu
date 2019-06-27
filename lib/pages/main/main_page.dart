import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutter_yuedu/pages/bookshelf/book_shelf_page.dart';
import 'package:flutter_yuedu/pages/course/course_page.dart';
import 'package:flutter_yuedu/pages/home/home_page.dart';
import 'package:flutter_yuedu/pages/my/my_page.dart';
import 'package:provider/provider.dart';

import 'main_provider.dart';

// tabBar数据B
List<Map<String, String>> _tabBarData = [
  {
    "title": "图书馆",
    "image": "images/tabbar/tabbar_book.png",
    "selectedImage": "images/tabbar/tabbar_pressed_book.png",
  },
  {
    "title": "课程",
    "image": "images/tabbar/tabbar_course.png",
    "selectedImage": "images/tabbar/tabbar_pressed_course.png",
  },
  {
    "title": "书架",
    "image": "images/tabbar/tabbar_bookshelf.png",
    "selectedImage": "images/tabbar/tabbar_pressed_bookshelf.png",
  },
  {
    "title": "我的",
    "image": "images/tabbar/tabbar_my.png",
    "selectedImage": "images/tabbar/tabbar_pressed_my.png",
  },
];

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
    final bottomBarHeight = 49 +
        MediaQuery.of(context).padding.bottom +
        (Platform.isAndroid ? 2 : 0);
    final mainState = Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xfffefefe),
      bottomNavigationBar: SizedBox(
        height: bottomBarHeight,
        child: _getBottomNavigationBar(mainState),
      ),
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

  /// bottomNavBar
  _getBottomNavigationBar(MainProvider mainState) {
    return BottomNavigationBar(
        currentIndex: mainState.getTabBarSelectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        unselectedItemColor: Color(0xff999999),
        selectedItemColor: Color(0xff666666),
        backgroundColor: Color(0xfffefefe),
        elevation: 1,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            mainState.setTabBarSelectedIndex = index;
          });
        },
        items: _getTabBar());
  }

  List<BottomNavigationBarItem> _getTabBar() {
    return [
      _getBottomBarItem(_tabBarData[0]["title"], _tabBarData[0]["image"],
          _tabBarData[0]["selectedImage"]),
      _getBottomBarItem(_tabBarData[1]["title"], _tabBarData[1]["image"],
          _tabBarData[1]["selectedImage"]),
      _getBottomBarItem(_tabBarData[2]["title"], _tabBarData[2]["image"],
          _tabBarData[2]["selectedImage"]),
      _getBottomBarItem(_tabBarData[3]["title"], _tabBarData[3]["image"],
          _tabBarData[3]["selectedImage"], _getBadge())
    ];
  }

  BottomNavigationBarItem _getBottomBarItem(
      String title, String image, String selectedImage,
      [Widget badge]) {
    const _tabBarIconWidth = 100.0;
    const _tabBarIconHeight = 22.0;

    final _badge = Positioned(
      left: _tabBarIconWidth / 2 + 5,
      child: badge ?? Container(),
    );

    return BottomNavigationBarItem(
        icon: Container(
          child: Stack(
            children: <Widget>[
              Image.asset(
                image,
                width: _tabBarIconWidth,
                height: _tabBarIconHeight,
              ),
              _badge,
            ],
          ),
        ),
        activeIcon: Stack(
          children: <Widget>[
            Image.asset(
              selectedImage,
              width: _tabBarIconWidth,
              height: _tabBarIconHeight,
            ),
            _badge
          ],
        ),
        title: Container(
          height: 16,
          alignment: Alignment.bottomCenter,
          child: Text(title),
        ));
  }

  _getBadge() {
    return Consumer<MainProvider>(
      builder: (context, MainProvider state, child) => Opacity(
            opacity: state.isMessageCount ? 1 : 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xfff8d949),
              ),
              height: 18,
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 6,
                ),
                child: Center(
                  child: Text(
                    state.getMessageCount,
                    style: TextStyle(color: Colors.white, fontSize: 10.5),
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
