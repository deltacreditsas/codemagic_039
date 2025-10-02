import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class FirebaseRemote {
  final FirebaseRemoteConfig _config;

  FirebaseRemote._(this._config);

  static const _defaultSurveyChance = 0;

  static Future<FirebaseRemote> init() async {
    final rc = FirebaseRemoteConfig.instance;

    await rc.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 30),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    await rc.setDefaults(<String, dynamic>{
      'survey_chance': _defaultSurveyChance,
    });

    try {
      await rc.fetchAndActivate();
    } catch (err) {
      debugPrint('⚠️ FirebaseRemote fetch error: $err');
    }

    return FirebaseRemote._(rc);
  }

  int getInt(String key) => _config.getInt(key);
}
