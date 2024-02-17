import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../app/util/util.dart';

class WebviewScreen extends StatefulWidget {
  final String paymentUrl;
  final String screenTitle;

  const WebviewScreen({
    Key? key,
    required this.paymentUrl,
    required this.screenTitle,
  }) : super(key: key);

  @override
  WebviewScreenState createState() => WebviewScreenState();
}

class WebviewScreenState extends State<WebviewScreen> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = kIsWeb || ![TargetPlatform.iOS, TargetPlatform.android].contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
                webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.screenTitle),
      ),
      body: Column(
        children: [
          Offstage(
            offstage: progress >= 1.0,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: LinearProgressIndicator(
                value: progress,
                color: Theme.of(context).primaryColor,
                minHeight: 4,
              ),
            ),
          ),
          Flexible(
            child: InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(
                url: WebUri.uri(
                  Uri.parse(widget.paymentUrl),
                ),
              ),
              initialUserScripts: UnmodifiableListView<UserScript>([]),
              initialSettings: InAppWebViewSettings(
                useShouldOverrideUrlLoading: false,
              ),
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) async => webViewController = controller,
              onLoadStart: (controller, uri) {},
              shouldOverrideUrlLoading: (controller, navigationAction) async => NavigationActionPolicy.ALLOW,
              onLoadStop: (controller, url) async {
                pullToRefreshController?.endRefreshing();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  pullToRefreshController?.endRefreshing();
                }
                setState(() => this.progress = progress / 100);
              },
              onUpdateVisitedHistory: (controller, url, isReload) {},
              onConsoleMessage: (controller, consoleMessage) => Utils.logMessage(consoleMessage.message),
            ),
          ),
        ],
      ),
    );
  }
}
