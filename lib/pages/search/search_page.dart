import 'package:flutter/material.dart';
import 'package:flutter_yuedu/widget/loading_animation.dart';
import 'package:flutter_yuedu/widget/main_refresh.dart';
import 'package:flutter_yuedu/widget/my_app_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffefefe),
      appBar: MyAppBar(),
      body: LoadingAnimation(
        loading: loading,
        child: GestureDetector(
          onTap: () {
            setState(() {
              loading = !loading;
            });
          },
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(!loading ? "显示动画" : "隐藏动画"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: MainRefresh(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
