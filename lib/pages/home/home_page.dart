import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yuedu/model/banner_model.dart';
import 'package:flutter_yuedu/model/book_model.dart';
import 'package:flutter_yuedu/model/column_model.dart';
import 'package:flutter_yuedu/model/header_model.dart';
import 'package:flutter_yuedu/model/home_quick_entrance_model.dart';
import 'package:flutter_yuedu/model/series_model.dart';
import 'package:flutter_yuedu/pages/login/login_page.dart';
import 'package:flutter_yuedu/pages/search/search_page.dart';
import 'package:flutter_yuedu/widget/loading_animation.dart';
import 'package:flutter_yuedu/widget/main_refresh.dart';
import 'package:provider/provider.dart';

import 'home_dropdown.dart';
import 'home_provider.dart';
import 'home_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: _appBar(),
      body: Consumer<HomeProvider>(builder: (_, state, __) {
        return LoadingAnimation(
          loading: state.isLoading,
          child: _listView(),
        );
      }),
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
    Provider.of<HomeProvider>(context).fetchData();
  }

  Widget _listView() {
    return CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: <Widget>[
            CupertinoSliverRefreshControl(
              builder: (context, mode, v1, v2, v3) {
                return MainRefresh();
              },
              onRefresh: _handleRefresh,
            )
          ] +
          _buildList(),
    );
  }

  List<Widget> _buildList() {
    final state = Provider.of<HomeProvider>(context);
    const padding = const EdgeInsets.fromLTRB(22, 5, 22, 5);

    if (state.data == null) return [];

    return state.data.modules.map((item) {
      final payload = item.payload;

      switch (item.type) {
        case "BANNER":
          return SliverToBoxAdapter(
            child: HomeBanner(BannerModel.fromJsonList(payload["banners"])),
          );
        case "QUICK_ENTRANCE":
          return SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
              child: HomeQuickEntrance(HomeQuickEntranceModel.fromJsonList(
                  payload["quickEntrances"])),
            ),
          );
        case "HEADER":
          return SliverToBoxAdapter(
            child: Padding(
              padding: padding,
              child: HomeHeader(HeaderModel.fromJsonMap(payload)),
            ),
          );
        case "NORMAL_BOOK":
        case "RECOMMENDED_BOOK":
          return HomeNormalBook(BookModel.fromJsonList(payload["books"]));
        case "TINY_BANNER":
          return SliverToBoxAdapter(
            child: Padding(
              padding: padding,
              child: HomeTinyBanner(
                  BannerModel.fromJsonMap(payload["tinyBanners"][0])),
            ),
          );
        case "HIGHLY_RECOMMENDED_BOOK":
          return HomeHighlyRecommendedBook(
              BookModel.fromJsonList(payload["books"]));
        case "COLUMN":
          return HomeColumn(ColumnModel.fromJsonList(payload["column"]));
        case "SERIES":
          return HomeSeries(SeriesModel.fromJsonList(payload["series"]));
        default:
          print("未实现的新增类型:" + item.type);
          break;
      }

      return SliverToBoxAdapter(
        child: Container(),
      );
    }).toList();
  }
}
