import 'package:flutter/material.dart';
import 'package:flutter_yuedu/pages/home/home_widget.dart';
import 'package:flutter_yuedu/widget/loading_animation.dart';
import 'package:flutter_yuedu/widget/my_app_bar.dart';
import 'package:provider/provider.dart';

import 'book_list_provider.dart';

class BookListHighlyRecommended extends StatefulWidget {
  final String id;

  BookListHighlyRecommended(this.id);

  @override
  _BookListHighlyRecommendedState createState() =>
      _BookListHighlyRecommendedState();
}

class _BookListHighlyRecommendedState extends State<BookListHighlyRecommended> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<BookListProvider>(context, listen: false);
    provider.fetchData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
        child: _getList(context),
      ),
    );
  }

  _getList(BuildContext context) {
    return Consumer<BookListProvider>(builder: (context, state, widget) {
      return LoadingAnimation(
        loading: state.isLoading,
        child: ListView.builder(
            itemExtent: 134,
            itemCount: state.data.length,
            itemBuilder: (_, index) {
              return HomeHighlyRecommendedBookItem(state.data[index]);
            }),
      );
    });
  }
}
