import 'package:flutter/material.dart';
import 'package:flutter_yuedu/widget/my_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key key, this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage>
    with AutomaticKeepAliveClientMixin {
  // 是否加载完成
  bool _loaded = false;

  String title = "";

  WebViewController _controller;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MyAppBar(
        title: MyTitle(title),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        color: Color(0xfffefefe),
        child: Stack(
          children: <Widget>[
            WebView(
              onWebViewCreated: (WebViewController controller) {
                _controller = controller;
              },
              onPageFinished: (url) {
                _controller.evaluateJavascript("document.title").then((value) {
                  setState(() {
                    title = value;
                  });
                });
                setState(() {
                  _loaded = true;
                });
              },
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
            ),
            // loading
            Positioned(
              child: Opacity(
                opacity: _loaded ? 0 : 1,
                child: _getLoadingDialog(),
              ),
            ),
          ],
        ),
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
