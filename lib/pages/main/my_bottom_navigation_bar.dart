import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_provider.dart';

// tabBar数据B
const List<Map<String, String>> _tabBarData = [
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

class MyBottomNavigationBar extends StatelessWidget {
  final ValueChanged<int> onTap;

  MyBottomNavigationBar({this.onTap});

  @override
  Widget build(BuildContext context) {
    final bottomBarHeight = 49 +
        MediaQuery.of(context).padding.bottom +
        (Platform.isAndroid ? 2 : 0);

    return SizedBox(
      height: bottomBarHeight,
      child: _getBottomNavigationBar(context),
    );
  }

  /// bottomNavBar
  _getBottomNavigationBar(BuildContext context) {
    final mainState = Provider.of<MainProvider>(context, listen: false);
    return BottomNavigationBar(
        currentIndex: mainState.getTabBarSelectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        unselectedItemColor: Color(0xff999999),
        selectedItemColor: Color(0xff666666),
        backgroundColor: Color(0xfffefefe),
        elevation: 2,
        onTap: this.onTap,
        items: _getTabBar(context));
  }

  List<BottomNavigationBarItem> _getTabBar(BuildContext context) {
    var index = 0;
    return _tabBarData.map((item) {
      return _getBottomBarItem(item["title"], item["image"],
          item["selectedImage"], context, index++ == 3 ? _getBadge() : null);
    }).toList();
  }

  BottomNavigationBarItem _getBottomBarItem(
      String title, String image, String selectedImage, BuildContext context,
      [Widget badge]) {
    print("dd");

    final _screenWidth = MediaQuery.of(context).size.width;
    final _tabBarIconWidth = _screenWidth / _tabBarData.length;
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
