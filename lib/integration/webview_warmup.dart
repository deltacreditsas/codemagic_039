import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserWarmUp extends ChangeNotifier {
  WebViewController? _webController;
  bool _pageLoaded = false;
  String? _pendingUrl;

  WebViewController? get webController => _webController;
  bool get isLoaded => _pageLoaded;
  String? get targetUrl => _pendingUrl;

  Future<void> warmUp(String url) async {
    _pendingUrl = url;

    await Future.delayed(const Duration(milliseconds: 50));

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            _pageLoaded = true;
            notifyListeners();
          },
          onWebResourceError: (err) {
            _pageLoaded = false;
            notifyListeners();
          },
        ),
      );

    try {
      await controller.loadRequest(Uri.parse(url));
      _webController = controller;
    } catch (e, _) {
      _pageLoaded = false;
      _webController = null;
      notifyListeners();
      rethrow;
    }
  }

  void reset() {
    _pageLoaded = false;
    _pendingUrl = null;
    _webController = null;
    notifyListeners();
  }
}
