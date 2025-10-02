import 'package:flutter_udid/flutter_udid.dart';
import 'package:logger/logger.dart';

final _log = Logger();

class IdentityService {
  String? _deviceId;

  Future<IdentityService> init() async {
    try {
      _deviceId = await FlutterUdid.udid;
      _log.i('[Identity] Got device UDID: $_deviceId');
    } catch (e, st) {
      _log.e('[Identity] Failed to get UDID', error: e, stackTrace: st);
      _deviceId = null;
    }
    return this;
  }

  String get id {
    if (_deviceId == null) {
      throw StateError('IdentityService not initialized!');
    }
    return _deviceId!;
  }
}
