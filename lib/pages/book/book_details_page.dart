import 'package:flutter/material.dart';
import 'package:flutter_yuedu/widget/my_app_bar.dart';

class BookDetailsPage extends StatefulWidget {
  final String id;

  const BookDetailsPage(this.id, {Key key}) : super(key: key);

  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Color(0xfffefefe),
      appBar: MyAppBar(
        title: MyTitle("详情"),
        actions: <Widget>[
          Container(
            width: 60,
            margin: const EdgeInsets.only(right: 5),
            child: FlatButton(
                onPressed: () => print("点击了分享按钮"),
                child: Image.asset("images/bookdetails/icon_share_22.png")),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 280,
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: 80,
                    child: Image.asset(
                        "images/bookdetails/player_bgTriangle.png")),
                Positioned(
                    right: 0,
                    bottom: 20,
                    child: Image.asset(
                        "images/bookdetails/player_bgCircle_light.png")),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xffefefef),
                              offset: Offset(0, 0),
                              blurRadius: 8)
                        ]),
                    height: 200,
                    width: 160,
                    child: Center(
                      child: Text(
                        "ID:" + widget.id,
                        style: TextStyle(color: Colors.black12),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
