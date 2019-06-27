import 'package:flutter/material.dart';
import 'package:flutter_yuedu/widget/my_app_bar.dart';

const APPBAR_SCROLL_OFFSET = 100;

class JoinMember extends StatefulWidget {
  @override
  _JoinMemberState createState() => _JoinMemberState();
}

class _JoinMemberState extends State<JoinMember> {
  double _appBarAlpha = 0; // appBar 透明

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color(0xfff7f7f8),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -_appBarAlpha * APPBAR_SCROLL_OFFSET,
            child: Image.asset(
              "images/member/member_background.png",
              fit: BoxFit.fitWidth,
              width: _mediaQuery.size.width,
            ),
          ),
          NotificationListener(
              onNotification: (ScrollNotification scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification)
                  _onScroll(scrollNotification.metrics.pixels);
                return false;
              },
              child: ListView(
                padding: EdgeInsets.only(top: 100),
                children: <Widget>[
                  Container(
                    height: 84,
                    padding: const EdgeInsets.only(left: 22),
                    child: Stack(
                      children: <Widget>[
                        Text(
                          "请登录",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff444444)),
                        ),
                        Positioned(
                            top: -10,
                            right: 15,
                            child: Image.asset(
                                "images/usercenter/usercenter_card_header_boy.png"))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Color(0xffeeeef0), blurRadius: 4)
                      ],
                      color: Colors.white,
                    ),
                    height: 300,
                    child: Text("你还不是会员"),
                  )
                ],
              )),
          MediaQuery.removePadding(
              removeTop: true,
              removeBottom: true,
              context: context,
              child: Container(
                height: kNavigationBarHeight + _mediaQuery.padding.top,
                padding: EdgeInsets.only(top: _mediaQuery.padding.top),
                color:
                    Color.fromARGB((_appBarAlpha * 255).toInt(), 255, 255, 255),
                child: MyAppBar(
                  backgroundColor: Colors.transparent,
                ),
              )),
          Positioned(
              top: kNavigationBarHeight + _mediaQuery.padding.top,
              left: 0,
              right: 0,
              child: Container(
                height: 5,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromARGB(
                          (120 * _appBarAlpha).toInt(), 245, 245, 245),
                      Color.fromARGB(0, 240, 240, 240)
                    ])),
              )),
          Positioned(
              right: 16,
              bottom: _mediaQuery.padding.bottom + 30,
              child: Image.asset("images/member/member_sales_sprite.png"))
        ],
      ),
    );
  }

  _onScroll(double offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      _appBarAlpha = alpha;
    });
  }
}
