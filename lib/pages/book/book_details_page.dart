import 'package:flutter/material.dart';
import 'package:flutter_yuedu/widget/my_app_bar.dart';

class BookDetailsPage extends StatefulWidget {
  final String url;

  const BookDetailsPage({Key key, this.url}) : super(key: key);

  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MyAppBar(
        title: MyTitle("详情"),
      ),
      body: Center(
        child: Text("xxxx"),
      ),
    );
  }
}
