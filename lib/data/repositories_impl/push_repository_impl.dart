import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logger/logger.dart';

import '../../domain/repositories/push_repository.dart';
import '../../integration/firebase_push.dart';

class PushRepositoryImpl implements PushRepository {
  final FirebasePush _firebasePush;

  PushRepositoryImpl(this._firebasePush);

  final Logger _log = Logger();

  @override
  Future<void> initialize() async {
    try {
      await _firebasePush.requestPermission();

      final token = await _firebasePush.fetchToken();
      _log.i('📲 Push token: $token');

      _attachListeners();
      _inspectInitialMsg();
    } catch (e, st) {
      _log.e('❌ Push init failed', error: e, stackTrace: st);
    }
  }


  @override
  Future<String?> getToken() => _firebasePush.fetchToken();

  @override
  bool consumePendingCreditFlag() => _firebasePush.takePendingCreditFlag();

  void _attachListeners() {
    FirebaseMessaging.onMessage.listen((msg) {
      _log.i('🔔 Foreground push: ${msg.messageId}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      _processMessage(msg, from: 'background');
    });
  }

  Future<void> _inspectInitialMsg() async {
    final initMsg = await _firebasePush.instance.getInitialMessage();
    if (initMsg != null) {
      _processMessage(initMsg, from: 'terminated');
    }
  }

  Future<void> _processMessage(RemoteMessage msg, {String from = ''}) async {
    _log.i('👉 Tap from $from, data=${msg.data}');

    final url = msg.data['url'];

    if (url != null && url.isNotEmpty) {
      try {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        _log.i('🌍 Opened external url=$url');
      } catch (e) {
        _log.w('⚠️ Failed to open url=$url, err=$e');
      }
    }
  }
}
