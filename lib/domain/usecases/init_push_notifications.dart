import '../repositories/push_repository.dart';

class InitPushNotifications {
  final PushRepository _repository;

  InitPushNotifications(this._repository);

  Future<void> call() async {
    await _repository.initialize();
  }
}
