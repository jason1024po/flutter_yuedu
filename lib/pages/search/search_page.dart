import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset("images/main/btn_back_normal.png"),
            ),
            backgroundColor: Colors.white,
            elevation: 0.3,
            centerTitle: true,
            expandedHeight: 100.0,
            floating: false,
            // 不随着滑动隐藏标题
            pinned: true,
            // 固定在顶部
          ),
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
