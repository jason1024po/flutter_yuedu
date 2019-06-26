import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yuedu/util/app_navigator.dart';
import 'package:flutter_yuedu/widget/my_app_bar.dart';

import 'mobile_login_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffefefe),
        appBar: MyAppBar(
          leadingType: AppBarBackType.Close,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: 80,
              child: SizedBox.expand(
                child: Image.asset(
                  "images/login/login_header.png",
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: 200,
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Color(0xff8d949),
                            offset: Offset(0, 3.0),
                            spreadRadius: 1.0,
                            blurRadius: 10.0)
                      ]),
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            color: Color(0xfff8d949),
                            onPressed: () {
                              _mobileLoginButtonTap(context);
                            },
                            child: Text(
                              "手机号码登录",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xfffefefe),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xfff5f5f5),
                                    offset: Offset(0, 3.0),
                                    spreadRadius: 1.0,
                                    blurRadius: 10.0)
                              ],
                              borderRadius: BorderRadius.circular(25)),
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)),
                              color: Color(0xfffefefe),
                              highlightColor: Color(0xfffefefe),
                              splashColor: Colors.transparent,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "微信登录",
                                style: TextStyle(fontSize: 15),
                              )),
                        ),
                      ),
                    ),
                    Text(
                      "未注册有道乐读的手机号，登录时将自动注册",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Image.asset("images/login/login_tail.png"),
            )
          ],
        ));
  }

  _mobileLoginButtonTap(BuildContext context) {
    AppNavigator.push(context, MobileLoginPage());
  }
}
