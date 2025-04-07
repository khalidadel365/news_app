import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewScreen extends StatelessWidget {
  dynamic url;
  WebViewScreen(this.url);
  WebViewController _controller = WebViewController();
  urlCreate (url) async {
    _controller.loadRequest(Uri.parse('$url'));
  }
  @override
  Widget build(BuildContext context) {
    urlCreate(url);
    return  Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
        controller: _controller,

      ),
    );
  }
}
