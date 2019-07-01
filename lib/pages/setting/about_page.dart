import 'package:flutter/material.dart';
import 'package:flutter_yuedu/widget/my_app_bar.dart';
import 'package:flutter_yuedu/widget/nav_large_title.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  var _version = "";

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffefefe),
      appBar: MyAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: <Widget>[
          NavLargeTitle("关于我们"),
          Image.asset("images/setting/about_logo.png"),
          Center(
            child: Text(_version),
          )
        ],
      ),
    );
  }

  _getInfo() async {
    print("dd");
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = "v${packageInfo.version}(${packageInfo.buildNumber})";
    });
  }
}
