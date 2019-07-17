import 'package:flutter/material.dart';
import 'package:flutter_yuedu/pages/home/home_widget.dart';
import 'package:flutter_yuedu/widget/loading_animation.dart';
import 'package:flutter_yuedu/widget/my_app_bar.dart';
import 'package:provider/provider.dart';

import 'book_list_provider.dart';

class BookList extends StatefulWidget {
  final String id;

  BookList(this.id);

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<BookListProvider>(context, listen: false);
    provider.fetchData(widget.id);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 100) {
        print('滑动到了最底部');
        provider.fetchData(widget.id, loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
        child: _getList(context),
      ),
    );
  }

  _getList(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Consumer<BookListProvider>(builder: (context, state, w) {
      return LoadingAnimation(
        loading: state.isLoading,
        child: GridView.builder(
          controller: _scrollController,
          itemCount: state.data?.length ?? 0,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (screenSize.width > screenSize.height) ? 6 : 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 0.64),
          itemBuilder: (_, index) => HomeNormalBookItem(state.data[index]),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
