import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/themes/app_palette.dart';
import '../../../common/themes/app_spacing.dart';
import '../../../common/themes/app_typography.dart';
import '../../../core/di/service_locator.dart';
import '../../../integration/network_observer.dart';
import '../../../integration/webview_warmup.dart';
import '../../no_internet/presentation/offline_layer.dart';

final _log = Logger();

class BrowserPage extends StatefulWidget {
  static const String id = 'browser_page';

  const BrowserPage({super.key, this.extra});

  final dynamic extra;

  @override
  State<BrowserPage> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowserPage> {
  late final WebViewController _webController;
  late final String _initialUrl;

  static const _externalSchemes = {'mailto', 'tel', 'sms', 'geo'};

  @override
  void initState() {
    super.initState();

    if (widget.extra is BrowserWarmUp) {
      final warmup = widget.extra as BrowserWarmUp;
      _webController = warmup.webController!;
      _initialUrl = warmup.targetUrl ?? '';
      _log.i('BrowserWarmUp used (preloaded)');
    } else if (widget.extra is String) {
      _initialUrl = widget.extra as String;
      _webController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.white)
        ..setNavigationDelegate(_buildDelegate())
        ..loadRequest(Uri.parse(_initialUrl));
      _log.i('Created WebView directly ($_initialUrl)');
    } else {
      _initialUrl = '';
      _webController = WebViewController();
      _log.w('️No URL for BrowserPage');
    }
  }

  NavigationDelegate _buildDelegate() {
    return NavigationDelegate(
      onNavigationRequest: (req) {
        try {
          final uri = Uri.tryParse(req.url);
          if (uri != null && _externalSchemes.contains(uri.scheme)) {
            launchUrl(uri, mode: LaunchMode.externalApplication);
            return NavigationDecision.prevent;
          }
        } catch (e, st) {
          FirebaseCrashlytics.instance.recordError(
            e,
            st,
            reason: 'Failed to handle navigation request: ${req.url}',
          );
        }
        return NavigationDecision.navigate;
      },
      onWebResourceError: (err) {
        FirebaseCrashlytics.instance.recordError(
          Exception('BrowserPage WebResourceError: ${err.description}'),
          StackTrace.current,
          reason: 'WebView navigation error',
        );
      },
    );
  }

  Future<void> _reloadWithUrl() async {
    try {
      if (_initialUrl.isNotEmpty) {
        _log.i('Refresh loadUrl($_initialUrl)');
        await _webController.loadRequest(Uri.parse(_initialUrl));
      }
    } catch (e, st) {
      FirebaseCrashlytics.instance.recordError(
        e,
        st,
        reason: 'Reload with URL failed',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final net = getIt<NetworkObserver>();

    return Scaffold(
      backgroundColor: context.palette.whiteColor,
      body: StreamBuilder<bool>(
        stream: net.onStatusChanged,
        initialData: net.online,
        builder: (context, snapshot) {
          final online = snapshot.data ?? true;

          return Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(context.spacing.size16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: SvgPicture.asset(
                              'assets/images/ic_back.svg',
                              width: context.spacing.size25,
                              height: context.spacing.size25,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              ('webview.title').tr(),
                              style: context.typography.semiBold24,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: context.spacing.size25),
                        ],
                      ),
                    ),
                    Expanded(child: WebViewWidget(controller: _webController)),
                  ],
                ),
              ),

              if (!online)
                Positioned.fill(child: OfflineLayer(onRetry: _reloadWithUrl)),
            ],
          );
        },
      ),
    );
  }
}
