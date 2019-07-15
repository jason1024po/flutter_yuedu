import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yuedu/util/my_navigator.dart';
import 'package:flutter_yuedu/widget/my_app_bar.dart';
import 'package:provider/provider.dart';

import 'book_list_provider.dart';

class BookList extends StatefulWidget {
  final String id;

  BookList(this.id);

  @override
  _BookList createState() => _BookList();
}

class _BookList extends State<BookList> {
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
            const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
        child: _getList(context),
      ),
    );
  }

  _getList(BuildContext context) {
    final provider = Provider.of<BookListProvider>(context, listen: false);

    final screenSize = MediaQuery.of(context).size;

    return GridView.builder(
        itemCount: provider.data?.length ?? 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (screenSize.width > screenSize.height) ? 6 : 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.64),
        itemBuilder: (_, index) => _getItem(provider.data[index]));
  }

  Widget _getItem(dynamic data) {
    return GestureDetector(
      onTap: () => MyNavigator.pushWithLink(data["link"]),
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0xffeaeaea),
                    offset: Offset(0.0, 1.0),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Stack(
                  children: <Widget>[
                    Container(
//                      width: 50,
                        color: Color(0xfffbfbfb),
                        child: CachedNetworkImage(
                          useOldImageOnUrlChange: true,
                          imageUrl: data["coverImageUrl"],
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        )),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: CachedNetworkImage(
                        imageUrl: data["subscriptUrl"] ?? "",
                      ),
                    )
                  ],
                ),
              ),
            )),
            Container(
              padding: const EdgeInsets.fromLTRB(4, 5, 4, 5),
              child: Text(
                data["title"],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
