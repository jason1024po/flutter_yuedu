import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yuedu/util/regular.dart';
import 'package:flutter_yuedu/widget/appbar_back.dart';

class MobileLoginPage extends StatefulWidget {
  @override
  _MobileLoginPageState createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {
  bool _mobileVerifyPassed = false; // 手机号是否验证能过

  TextEditingController _codeVerifyTFController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffefefe),
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Color(0xfffefefe),
        elevation: 0,
        leading: AppBarBack(),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 12, bottom: 12),
              child: Text(
                "手机号登录",
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
              child: _mobileTextField(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
              child: _codeTextField(),
            ),
            Container(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
              child: Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: "点击登录，即表示已阅读并同意"),
                  TextSpan(
                      text: "《有道乐读用户协议》",
                      style: TextStyle(color: Colors.orange))
                ], style: TextStyle(fontSize: 12, color: Color(0xff999999)))),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
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
                    disabledColor: Color(0xfffdf5c7),
                    onPressed: _loginButtonTap,
                    child: Text(
                      "登 录",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  _loginButtonTap() {
    print("我在登录");
    Navigator.popUntil(
        context, ModalRoute.withName(Navigator.defaultRouteName));
  }

  _mobileTextField() {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 18, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Color(0xfff8f8f8),
      ),
      child: TextField(
        cursorColor: Colors.amber,
        onChanged: _mobileTextChange,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "请输入手机号码",
            hintStyle: TextStyle(color: Color(0xffdddddd), fontSize: 15),
            icon: Text(
              "+86",
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff666666),
                  fontWeight: FontWeight.w500),
            ),
            suffixIcon: Container(
              margin: const EdgeInsets.only(top: 9, bottom: 9),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Color(0xfff2f2f2), blurRadius: 3)
              ], borderRadius: BorderRadius.circular(15)),
              child: ButtonTheme(
                minWidth: 90,
                height: 20,
                disabledColor: Color(0xfffefefe),
                child: RaisedButton(
                  onPressed: !_mobileVerifyPassed ? null : _getVerifyCode,
                  elevation: 0.0,
                  highlightElevation: 0.0,
                  color: Color(0xfffefefe),
                  disabledTextColor: Color(0xffc1c1c1),
                  textColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "发送验证码",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            )),
        keyboardType: TextInputType.phone,
      ),
    );
  }

  _codeTextField() {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 24, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Color(0xfff8f8f8),
      ),
      child: TextField(
        controller: _codeVerifyTFController,
        cursorColor: Colors.amber,
        onChanged: _mobileTextChange,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "请输入验证码",
          hintStyle: TextStyle(color: Color(0xffdddddd), fontSize: 15),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  _mobileTextChange(String text) {
    setState(() {
      _mobileVerifyPassed = Regular.isMobile(text);
    });
  }

  _getVerifyCode() {
    Future.delayed(Duration(seconds: 2), () {
      _codeVerifyTFController.text = "1234";
      setState(() {});
    });
  }
}
