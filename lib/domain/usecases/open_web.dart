import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../../core/di/service_locator.dart';
import '../../common/const/const_key.dart';
import '../../integration/webview_warmup.dart';
import '../../sections/webview/presentation/browser_page.dart';

final _log = Logger();

extension WebLauncher on BuildContext {
  Future<void> openWeb() async {
    final preloader = getIt<BrowserWarmUp>();

    if (preloader.isLoaded && preloader.webController != null) {
      _log.i('Opening preloaded WebView');
      push('/${BrowserPage.id}', extra: preloader);
    } else {
      _log.i('Opening WebView with URL');
      const url = ConstKey.urlWV;
      push('/${BrowserPage.id}', extra: url);
    }
  }
}
