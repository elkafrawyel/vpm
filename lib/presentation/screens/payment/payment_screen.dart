import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../app/util/util.dart';
import '../../widgets/app_widgets/app_text.dart';

class PaymentScreen extends StatefulWidget {
  final String paymentUrl;
  final Function() onPaymentSuccess;
  final Function() onPaymentFailed;
  final String screenTitle;

  const PaymentScreen({
    Key? key,
    required this.paymentUrl,
    required this.onPaymentSuccess,
    required this.onPaymentFailed,
    required this.screenTitle,
  }) : super(key: key);

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey webViewKey = GlobalKey();

  final successUrl = 'https://www.google.com/';
  final failedUrl = 'https://gramdahab.com/api/auth/failure';

  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = kIsWeb ||
            ![TargetPlatform.iOS, TargetPlatform.android]
                .contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS ||
                  defaultTargetPlatform == TargetPlatform.macOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
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
              onWebViewCreated: (controller) async =>
                  webViewController = controller,
              onLoadStart: (controller, uri) async {
                if (uri == null) {
                  return;
                }
                Utils.logMessage('uri => $uri');
                String url = uri.toString();
                if (url.contains(successUrl)) {
                  widget.onPaymentSuccess();
                  Utils.logMessage('payment success');
                } else if (url.contains(failedUrl)) {
                  widget.onPaymentFailed();
                  Utils.logMessage('payment failed');
                } else {
                  Utils.logMessage('Unhandled WebView Url');
                }
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async =>
                  NavigationActionPolicy.ALLOW,
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
              onConsoleMessage: (controller, consoleMessage) =>
                  Utils.logMessage(consoleMessage.message),
            ),
          ),
        ],
      ),
    );
  }
}
