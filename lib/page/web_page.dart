import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

///WebView
class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage(this.url, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text(title ??= ""),
        actions: <Widget>[new Padding(padding: EdgeInsets.all(12))],
      ),
      body: new InAppWebView(
        initialUrl: widget.url,
        initialOptions: new InAppWebViewGroupOptions(
          crossPlatform: new InAppWebViewOptions(
                useShouldOverrideUrlLoading: true,
          )
        ),
        shouldOverrideUrlLoading: (controller, url) async {
          ///拦截唤起知乎app的scheme
          if (url.url.startsWith("zhihu://")) {
            return ShouldOverrideUrlLoadingAction.CANCEL;
          } else {
            return ShouldOverrideUrlLoadingAction.ALLOW;
          }
        },
        onProgressChanged: (controller, progress) {
          controller.getTitle().then((title) {
            setState(() {
              this.title = title;
            });
          });
        },
      ),
    );
  }
}
