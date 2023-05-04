import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'Utils.dart';
import 'dart:io';
import 'dart:async';
import 'Utils.dart';

class ReviewMap extends StatefulWidget {
  final double flat;
  final double flon;
  final double lat;
  final double lon;
  const ReviewMap(
      {super.key,
      required this.lat,
      required this.lon,
      required this.flat,
      required this.flon});

  @override
  State<ReviewMap> createState() => _ReviewMapState();
}

class _ReviewMapState extends State<ReviewMap> {
  var controller = null;

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
        child: Card(
            clipBehavior: Clip.hardEdge,
            elevation: 2,
            child: WebView(
              initialUrl: "${getUrl()}review",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                webViewController.evaluateJavascript(
                    "adjustFarmer('${widget.flon}','${widget.flat}','${widget.lon}','${widget.lat}')");
               
                controller = webViewController;
              },
              onPageFinished: (v) {
                controller?.evaluateJavascript(
                    "adjustFarmer('${widget.flon}','${widget.flat}','${widget.lon}','${widget.lat}')");
              },
            )));
  }
}
