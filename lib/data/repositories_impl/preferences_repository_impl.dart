import '../../domain/repositories/preferences_repository.dart';
import '../local/prefs_storage.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  final PrefsStorage _storage;

  PreferencesRepositoryImpl(this._storage);

  // Onboarding
  @override
  Future<void> setOnboardingComplete(bool value) =>
      _storage.setOnboardingComplete(value);

  @override
  bool isOnboardingComplete() => _storage.isOnboardingComplete();

  // Review
  @override
  Future<int> increaseLaunchCounter() => _storage.increaseLaunchCounter();

  @override
  int getLaunchCount() => _storage.getLaunchCount();

  @override
  Future<void> setReviewShown(bool value) => _storage.setReviewShown(value);

  @override
  bool isReviewAlreadyShown() => _storage.isReviewAlreadyShown();

  // UUID
  @override
  Future<void> saveUuid(String uuid) => _storage.saveUuid(uuid);

  @override
  String? getUuid() => _storage.getUuid();

  @override
  Future<void> clearUuid() => _storage.clearUuid();

  // Custom Review
  @override
  Future<void> setCustomReviewShown(bool value) =>
      _storage.setCustomReviewShown(value);

  @override
  bool isCustomReviewShown() => _storage.isCustomReviewShown();
}
