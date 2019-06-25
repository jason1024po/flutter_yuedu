import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateVersion {
  String appStoreUrl;
  String apkUrl;
  String content;
}

class UpdateVersionDialog extends Dialog {
  UpdateVersionDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _maxContentHeight =
        min(MediaQuery.of(context).size.height - 270, 180.0);
    final EdgeInsets padding = MediaQuery.of(context).padding;
    print(padding);

    return Material(
        type: MaterialType.transparency,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 265,
                  decoration: ShapeDecoration(
                      color: Color(0xFFFFFFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                      )),
                  child: Column(children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          topRight: Radius.circular(6.0),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 110,
                            ),
                            Image.asset("images/update/ic_update_bg.png")
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: Center(
                            child: new Text('升级到新版本',
                                style: new TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                )))),
                    Container(
                      child: Text(
                        'v1.1.1',
                        style: TextStyle(
                            color: Color(0xff3782e5),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: _maxContentHeight),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: SingleChildScrollView(
                          child: Text(
                            '1.Bug解决Bug解决Bug解决Bug解决Bug解决\n 2.xxxx1.Bug解决Bug解决Bug解决Bug解决Bug解决\n 2.xxxx1.Bug解决Bug解决Bug解决Bug解决Bug解决\n 2.xxxx1.Bug解决Bug解决Bug解决Bug解决Bug解决\n 2.xxxx1.Bug解决Bug解决Bug解决Bug解决Bug解决\n 2.xxxx1.Bug解决Bug解决Bug解决Bug解决Bug解决\n 2.xxxx1.Bug解决Bug解决Bug解决Bug解决Bug解决\n 2.xxxx1.Bug解决Bug解决Bug解决Bug解决Bug解决\n 2.xxxx1.Bug解决Bug解决Bug解决Bug解决Bug解决\n 2.xxxx1.Bug解决Bug解决Bug解决Bug解决Bug解决\n 2.xxxx1.Bug解决Bug解决Bug解决Bug解决Bug解决\n 2.xxxx',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(33, 0, 33, 0),
                      child: Container(
                        height: 1.0 /
                            MediaQueryData.fromWindow(window).devicePixelRatio,
                        color: Color(0xffC0C0C0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: 170,
                        height: 40,
                        child: RaisedButton(
                            child: Text(
                              "立即升级",
                              style: TextStyle(color: Color(0xdfffffff)),
                            ),
                            color: const Color(0xff5f9afa),
                            onPressed: () {
                              _updateButtonTap(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 10),
                        child: SizedBox(
                          height: 30,
                          child: FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              textColor: Colors.black26,
                              color: Colors.transparent,
                              highlightColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                "暂不升级",
                                style: TextStyle(fontSize: 13),
                              )),
                        ))
                  ]))
            ]));
  }

  _updateButtonTap(BuildContext context) async {
    Navigator.pop(context);
    if (Platform.isIOS) {
      const url = 'https://itunes.apple.com/cn/app/id1380512641';
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        throw 'Could not launch $url';
      }
    } else if (Platform.isAndroid) {
      print("下载 apk");
    }
  }
}
