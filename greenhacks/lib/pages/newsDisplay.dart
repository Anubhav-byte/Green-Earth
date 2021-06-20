import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDisplay extends StatefulWidget {
  final url;
  NewsDisplay(this.url);

  @override
  _NewsDisplayState createState() => _NewsDisplayState(this.url);
}

class _NewsDisplayState extends State<NewsDisplay> {
  final url;

  _NewsDisplayState(this.url);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog",),
        backgroundColor: Colors.white,
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}

