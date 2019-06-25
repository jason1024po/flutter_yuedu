import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_yuedu/pages/login/login_page.dart';
import 'package:flutter_yuedu/pages/search/search_page.dart';

import 'home_dropdown.dart';

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  final _bannerList = [
    "http://ydschool-online.nos.netease.com/rs_88874c6f89ec48c996ea289ed4bb952e.jpg",
    "http://ydschool-online.nos.netease.com/rs_9ad9ee7ddc9643a79ef6f3456c3c0e9f.jpg",
    "http://ydschool-online.nos.netease.com/rs_a661796665db47b29f3167c8e43635ef.jpg",
    "http://ydschool-online.nos.netease.com/rs_af7ba6d4206945ba9357b4863fb569a9.jpg",
    "http://ydschool-online.nos.netease.com/rs_b44ba0d8f01e48439dae9c2d22a41b20.jpg",
  ];
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: _appBar(),
      body: RefreshIndicator(child: _listView(), onRefresh: _handleRefresh),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      elevation: 0.0,
      flexibleSpace: SizedBox.expand(
          child: Container(
              child: Stack(
        children: <Widget>[
          Positioned(
            child: GestureDetector(
              onTap: () {
                _stageDropdown();
                print("阶段岁数点击");
              },
              child: Container(
                  height: 56,
                  child: Row(
                    children: <Widget>[
                      Center(
                        child: Text(
                          "0~3岁",
                          style: TextStyle(
                              fontSize: 17,
                              color: Color(0xff444444),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Image.asset("images/main/main_stage_arrow.png")
                    ],
                  )),
            ),
            bottom: 0,
            left: 60,
          )
        ],
      ))),
      actions: <Widget>[_searchItem()],
      leading: Container(
          child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(
              fullscreenDialog: true, builder: (context) => LoginPage()));
        },
        child: Image.asset("images/usercenter/usercenter_unlogin_header.png"),
      )),
    );
  }

  Widget _searchItem() {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchPage()),
          );
        },
        child: Image.asset("images/main/main_search.png"),
      ),
    );
  }

  Future<void> _stageDropdown() async {
    return showGeneralDialog(
      context: context,
      barrierLabel: "你好",
      barrierDismissible: true,
      barrierColor: Color(0x9a000000),
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return StageDialog();
      },
    );
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      print('refresh');
      setState(() {
        return null;
      });
    });
  }

  Widget _listView() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(child: _banner()),
        SliverToBoxAdapter(child: _iconMenu()),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: _categoryBar("阅读萌芽期 热门畅销"),
          ),
        ),
        _bookGrid(),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                  imageUrl:
                      "https://oimagec8.ydstatic.com/image?id=-6043440067699066638&product=xue"),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: _categoryBar("本周新书"),
          ),
        ),
        _bookGrid(),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: _categoryBar("宝宝巴士-律动系列"),
          ),
        ),
        _bookGrid(),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: _categoryBar("宝宝巴士-律动系列"),
          ),
        ),
        _bookList()
      ],
    );
  }

  Widget _bookList() {
    final _data = [
      "https://nos.netease.com/ydschool-online/rs_3f38182591984f4ab3196731259ef1e0.jpg",
      "https://nos.netease.com/ydschool-online/rs_b421cd285f5c44b49efd77fe5bcb434f.jpg",
      "https://nos.netease.com/ydschool-online/rs_993b2ed0d1854de5b70dbaa7e37053e0.jpg",
    ];
    return SliverFixedExtentList(
      itemExtent: 130.0,
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0xffeaeaea),
                      offset: Offset(0.0, 1.0),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Container(
                      width: 77,
                      color: Color(0xfffbfbfb),
                      child: Image.network(
                        _data[index],
                        fit: BoxFit.cover,
                        height: 106,
                      )),
                ),
              ),
              Positioned(
                top: 5,
                left: 95,
                right: 0,
                child: Text(
                  "奶泡泡学古诗（第一季)",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color(0xff444444),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                top: 28,
                left: 95,
                right: 0,
                child: Text(
                  "致力于培养孩子想象力与创造力的声音主播。)",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(color: Color(0xff9b9b9b), fontSize: 12),
                ),
              ),
              Positioned(
                top: 75,
                left: 95,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Color(0xfff8f8f8),
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    "国学启蒙/古诗课程/兴趣培养",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Color(0xff979797), fontSize: 12),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 1,
                right: 1,
                child: Divider(),
              )
            ],
          ),
        );
      }, childCount: _data.length),
    );
  }

  Widget _bookGrid() {
    final _data = [
      "https://nos.netease.com/ydschool-online/rs_3f38182591984f4ab3196731259ef1e0.jpg",
      "https://nos.netease.com/ydschool-online/rs_b421cd285f5c44b49efd77fe5bcb434f.jpg",
      "https://nos.netease.com/ydschool-online/rs_993b2ed0d1854de5b70dbaa7e37053e0.jpg",
      "https://nos.netease.com/ydschool-online/rs_3f38182591984f4ab3196731259ef1e0.jpg",
      "https://nos.netease.com/ydschool-online/rs_b421cd285f5c44b49efd77fe5bcb434f.jpg",
      "https://nos.netease.com/ydschool-online/rs_993b2ed0d1854de5b70dbaa7e37053e0.jpg"
    ];
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      sliver: SliverGrid(
        //Grid
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 110,
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 5.0,
            childAspectRatio: 0.8),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0xffeaeaea),
                      offset: Offset(0.0, 1.0),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Container(
                      height: 132,
                      width: 100,
                      color: Color(0xfffbfbfb),
                      child: Image.network(
                        _data[index],
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            );
          },
          childCount: _data.length,
        ),
      ),
    );
  }

  // banner
  Widget _banner() {
    final screenWidth = MediaQuery.of(context).size.width * 1.0;

    final fraction = (375.0 / screenWidth * 100).toInt() * 0.9 / 100;

    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 150,
      child: Swiper(
        viewportFraction: fraction,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Padding(
                padding: EdgeInsets.only(left: 6, right: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: CachedNetworkImage(
                    imageUrl: _bannerList[index],
                  ),
                )),
          );
        },
        itemCount: _bannerList.length,
      ),
    );
  }

  // 菜单
  Widget _iconMenu() {
    return Container(
      margin: EdgeInsets.only(top: 12, bottom: 12),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          _menuItem("新书推荐",
              "http://ydschool-online.nos.netease.com/rs_2b62310272c74032a89795fa352dda8f.jpg"),
          _menuItem("必读书单",
              "http://ydschool-online.nos.netease.com/rs_20d90f4d82bb4e22b5ea9ffd56a0317f.jpg"),
          _menuItem("免费上课",
              "http://ydschool-online.nos.netease.com/rs_f2ca49a136e743ae99bafa3de585a9ee.jpg"),
          _menuItem("阅读顾问",
              "http://ydschool-online.nos.netease.com/rs_1c09cc90f5504e228888eb01cb99f0db.jpg"),
        ],
      ),
    );
  }

  Widget _menuItem(String title, String url) {
    return Expanded(
      flex: 1,
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            width: 60,
            height: 60,
            imageUrl: url,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              title,
              style: TextStyle(color: Color(0xff6e6e6e), fontSize: 11),
            ),
          )
        ],
      ),
    );
  }

  // 标题栏
  Widget _categoryBar(String title) {
    return Container(
//       margin: EdgeInsets.only(top: 10,bottom: 10),
        height: 44,
        child: Row(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl:
                  "http://ydschool-online.nos.netease.com/rs_7493e8a4ac55437e8192b4fbf01d4a5d.png",
              width: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 17,
                    color: Color(0xff444444),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.centerRight,
              child: Image.asset("images/main/main_more_arrow.png"),
            ))
          ],
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}
