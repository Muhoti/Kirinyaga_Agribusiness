import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'Utils.dart';
import 'dart:io';

class MapEdit extends StatefulWidget {
  final double lat;
  final double lon;
  final double oldlong;
  final double oldlat;
  const MapEdit(
      {super.key,
      required this.lat,
      required this.lon,
      required this.oldlat,
      required this.oldlong});

  @override
  State<MapEdit> createState() => _MapEditState();
}

class _MapEditState extends State<MapEdit> {
  var controller = null;

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    print("passed data ${widget.lon}, ${widget.oldlong}");
    super.initState();
  }

  @mustCallSuper
  @protected
  void didUpdateWidget(covariant oldWidget) {
    print("passed data ${widget.lon}, ${widget.oldlong}");
    if (oldWidget.oldlat != widget.oldlat ||
        oldWidget.oldlong != widget.oldlong) {
      if (controller != null) {
        controller.evaluateJavascript(
            "adjustMarker('${widget.lon}', '${widget.lat}', '${widget.oldlong}','${widget.oldlat}')");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
        child: Card(
            clipBehavior: Clip.hardEdge,
            elevation: 2,
            child: WebView(
              initialUrl: "${getUrl()}farmeraddress",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                controller = webViewController;
                webViewController.evaluateJavascript(
                    "adjustMarker('${widget.lon}', '${widget.lat}', '${widget.oldlong}','${widget.oldlat}')");
              },
              onPageFinished: (v) {
                controller.evaluateJavascript(
                    "adjustMarker('${widget.lon}', '${widget.lat}', '${widget.oldlong}','${widget.oldlat}')");
              },
            )));
  }
}
