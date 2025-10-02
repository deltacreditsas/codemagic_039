import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebasePush {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  bool _pendingCreditFlag = false;

  Future<void> requestPermission() async {
    await _messaging.requestPermission();
  }

  Future<String?> fetchToken() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      String? apnsToken;
      int retries = 0;

      while (apnsToken == null && retries < 2) {
        apnsToken = await _messaging.getAPNSToken();
        if (apnsToken == null) {
          await Future.delayed(const Duration(seconds: 1));
          retries++;
        }
      }

      if (apnsToken == null) {
        debugPrint('⚠️ APNs token still not available after retries');
        return null;
      }
    }

    return await _messaging.getToken();
  }

  void setPendingCreditFlag() {
    _pendingCreditFlag = true;
  }

  bool takePendingCreditFlag() {
    final res = _pendingCreditFlag;
    _pendingCreditFlag = false;
    return res;
  }

  FirebaseMessaging get instance => _messaging;
}
