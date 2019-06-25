import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutter_yuedu/pages/bookshelf/book_shelf_page.dart';
import 'package:flutter_yuedu/pages/course/course_page.dart';
import 'package:flutter_yuedu/pages/home/home_page.dart';
import 'package:flutter_yuedu/pages/my/my_page.dart';
import 'package:provider/provider.dart';

import 'main_state.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _defaultColor = Color(0xff999999);
  final _activeColor = Color(0xff666666);

  // 当前选择
//  int _currentIndex = 0;

  // tabBar数据B
  List<Map<String, String>> _tabBarData;

  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    _tabBarData = [
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
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      // 隐藏启动屏
      FlutterSplashScreen.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainState = Provider.of<MainState>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: mainState.getTabBarSelectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          unselectedItemColor: _defaultColor,
          selectedItemColor: _activeColor,
          iconSize: 30,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              mainState.setTabBarSelectedIndex = index;
//              _currentIndex = index;
            });
          },
          items: _getTabBar()),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          CoursePage(),
          BookShelfPage(),
          MyPage(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  List<BottomNavigationBarItem> _getTabBar() {
    return [
      _tabBarItem(_tabBarData[0]["title"], _tabBarData[0]["image"],
          _tabBarData[0]["selectedImage"]),
      _tabBarItem(_tabBarData[1]["title"], _tabBarData[1]["image"],
          _tabBarData[1]["selectedImage"]),
      _tabBarItem(_tabBarData[2]["title"], _tabBarData[2]["image"],
          _tabBarData[2]["selectedImage"]),
      _tabBarMessageBadgeItem(_tabBarData[3]["title"], _tabBarData[3]["image"],
          _tabBarData[3]["selectedImage"])
    ];
  }

  BottomNavigationBarItem _tabBarItem(
      String title, String image, String selectedImage) {
    const iconWidth = 80.0;
    return BottomNavigationBarItem(
        icon: Stack(
          children: <Widget>[
            Image.asset(
              image,
              width: iconWidth,
              height: 30,
            ),
          ],
        ),
        activeIcon: Stack(
          children: <Widget>[
            Image.asset(
              selectedImage,
              width: iconWidth,
              height: 30,
            ),
          ],
        ),
        title: Text(title));
  }

  BottomNavigationBarItem _tabBarMessageBadgeItem(
      String title, String image, String selectedImage) {
    const iconWidth = 80.0;

    var badgeIcon = Positioned(
      left: iconWidth / 2 + 6,
      child: Consumer<MainState>(
        builder: (context, MainState state, child) => Opacity(
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
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
    return BottomNavigationBarItem(
        icon: Stack(
          children: <Widget>[
            Image.asset(
              image,
              width: iconWidth,
              height: 30,
            ),
            badgeIcon,
          ],
        ),
        activeIcon: Stack(
          children: <Widget>[
            Image.asset(
              selectedImage,
              width: iconWidth,
              height: 30,
            ),
            badgeIcon
          ],
        ),
        title: Text(title));
  }
}
