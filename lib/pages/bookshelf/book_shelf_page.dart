import 'package:flutter/material.dart';
import 'package:flutter_yuedu/widget/my_app_bar.dart';
import 'package:flutter_yuedu/widget/nav_large_title.dart';
import 'package:underline_indicator/underline_indicator.dart';

class BookShelfPage extends StatefulWidget {
  @override
  _BookShelfPageState createState() => _BookShelfPageState();
}

class _BookShelfPageState extends State<BookShelfPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  TabController _tabController; //需要定义一个Controller
  List tabs = ["阅读记录", "有声书", "电子书", "订阅专栏", "已缓存"];

  @override
  void initState() {
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);

    _tabController.addListener(() {
      print(_tabController.index);
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const tabHeight = 40.0;
    return Scaffold(
      backgroundColor: Color(0xfffefefe),
      appBar: PreferredSize(
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color(0xfff5f5f5),
                  offset: Offset(0, 3),
                  blurRadius: 10)
            ]),
            child: AppBar(
              backgroundColor: Color(0xfffefefe),
              brightness: Brightness.light,
              elevation: 0.3,
              centerTitle: false,
              title: NavLargeTitle("我的书架"),
              bottom: PreferredSize(
                child: Container(
                  height: tabHeight,
                  child: TabBar(
                      controller: _tabController,
                      indicator: UnderlineIndicator(
                          strokeCap: StrokeCap.round,
                          borderSide: BorderSide(
                            color: Color(0xfff8d949),
                            width: 4,
                          ),
                          insets: EdgeInsets.only(left: 15, right: 15)),
                      isScrollable: true,
                      labelStyle: TextStyle(fontSize: 15),
                      unselectedLabelStyle: TextStyle(color: Color(0xff999999)),
                      labelColor: Color(0xff333333),
                      tabs: tabs
                          .map((e) => Container(
                                child: Tab(text: e),
                              ))
                          .toList()),
                ),
                preferredSize: null,
              ),
            ),
          ),
          preferredSize: Size.fromHeight(kNavigationBarHeight + tabHeight)),
      body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            return UnLoginWidget();
          }).toList()),
    );
  }
}

class UnLoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          height: 240,
          child: Column(
            children: <Widget>[
              Image.asset(
                "images/bookshelf/bg_bookshelf_empty.png",
                height: 118,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 230,
                  height: 44,
                  child: FlatButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(44.0)),
                    child: Text(
                      "登 录",
                      style: TextStyle(color: Color(0xff444444), fontSize: 16),
                    ),
                    color: Color(0xfff8d949),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
