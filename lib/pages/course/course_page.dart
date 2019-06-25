import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> with AutomaticKeepAliveClientMixin {
  // 是否加载完成
  bool _loaded = false;
  String url = "https://ke.du.youdao.com/course/goods";


  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Stack(
        children: <Widget>[
          WebView(
            onPageFinished: (url) {
              setState(() {
                _loaded = true;
              });
            },
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
          ),
          // loading
          Positioned(
            child: Opacity(
              opacity: _loaded ? 0 : 1,
              child: _getLoadingDialog(),
            ),
          ),
          // 导航栏背景
          Positioned(
            top:0,
            child: Container(color: Colors.white, height: MediaQuery.of(context).padding.top, width: MediaQuery.of(context).size.width,),
          )
        ],
      ),
    );
  }

  Widget _getLoadingDialog() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.amber,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
      ),
    );
  }
}
