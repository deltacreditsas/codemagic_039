import 'package:webview_flutter/webview_flutter.dart';

import '../../integration/webview_warmup.dart';

class PreloadWebView {
  final BrowserWarmUp _warmUp;

  PreloadWebView(this._warmUp);

  Future<WebViewController?> call(String url) async {
    await _warmUp.warmUp(url);

    while (!_warmUp.isLoaded) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    return _warmUp.webController;
  }
}
