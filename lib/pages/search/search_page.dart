import 'package:flutter/material.dart';
import 'package:flutter_yuedu/widget/my_app_bar.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffefefe),
      appBar: MyAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    child: index % 5 == 0 ? Text("1") : Text("2"));
              }, childCount: 50),
            ),
          ),
        ],
      ),
    );
  }
}
