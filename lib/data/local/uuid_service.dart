import 'package:flutter_udid/flutter_udid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UuidService {
  final SharedPreferences _prefs;

  UuidService(this._prefs);

  static const _keyUuid = 'device_uuid';

  Future<String> getOrCreateUuid() async {
    String? uuid = _prefs.getString(_keyUuid);

    if (uuid == null || uuid.isEmpty) {
      uuid = await FlutterUdid.udid;
      await _prefs.setString(_keyUuid, uuid);
    }

    return uuid;
  }

  String? getStoredUuid() {
    return _prefs.getString(_keyUuid);
  }

  Future<void> clearUuid() async {
    await _prefs.remove(_keyUuid);
  }
}
