import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS/macOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

class GoogleLensWebview extends StatefulWidget {
  const GoogleLensWebview({super.key});

  @override
  State<GoogleLensWebview> createState() => _GoogleLensWebviewState();
}

class _GoogleLensWebviewState extends State<GoogleLensWebview> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
              ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   debugPrint('blocking navigation to ${request.url}');
            //   return NavigationDecision.prevent;
            // }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('Error occurred on page: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            openDialog(request);
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message.message)));
        },
      )
      ..loadRequest(Uri.parse('https://google.com'));

    // setBackgroundColor is not currently supported on macOS.
    if (kIsWeb || !Platform.isMacOS) {
      controller.setBackgroundColor(const Color(0x80000000));
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Flutter WebView example'),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
          NavigationControls(webViewController: _controller),
          // SampleMenu(webViewController: _controller),
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}


Future<void> openDialog(HttpAuthRequest httpRequest) async {
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key, required this.webViewController});

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No back history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            if (await webViewController.canGoForward()) {
              await webViewController.goForward();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No forward history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () => webViewController.reload(),
        ),
      ],
    );
  }

  Future<void> _promptForUrl(BuildContext context) {
    final TextEditingController urlTextController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Input URL to visit'),
          content: TextField(
            decoration: const InputDecoration(labelText: 'URL'),
            autofocus: true,
            controller: urlTextController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (urlTextController.text.isNotEmpty) {
                  final Uri? uri = Uri.tryParse(urlTextController.text);
                  if (uri != null && uri.scheme.isNotEmpty) {
                    webViewController.loadRequest(uri);
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text('Visit'),
            ),
          ],
        );
      },
    );
  }
}
