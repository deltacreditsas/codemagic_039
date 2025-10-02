import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkObserver extends ChangeNotifier {
  final InternetConnection _checker = InternetConnection();

  bool _online = true;
  bool get online => _online;

  final StreamController<bool> _notifier = StreamController<bool>.broadcast();
  Stream<bool> get onStatusChanged => _notifier.stream;

  StreamSubscription<InternetStatus>? _subscription;
  bool _started = false;

  Future<void> start() async {
    if (_started) return;
    _started = true;

    _online = await _checker.hasInternetAccess;
    _emit(_online);

    _subscription = _checker.onStatusChange.listen((status) async {
      final current = status == InternetStatus.connected
          ? await _checker.hasInternetAccess
          : false;
      if (current != _online) {
        _online = current;
        _emit(_online);
      }
    });
  }

  void _emit(bool value) {
    _notifier.add(value);
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _notifier.close();
    super.dispose();
  }
}
