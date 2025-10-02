import 'package:shared_preferences/shared_preferences.dart';

class PrefsStorage {
  final SharedPreferences _prefs;

  PrefsStorage(this._prefs);

  //KEYS
  static const _keyOnboardingComplete = 'onboarding_complete';
  static const _keyAppLaunchCount = 'app_launch_count';
  static const _keyReviewShown = 'review_shown';
  static const _keyUuid = 'device_uuid';
  static const _keyCustomReview = 'custom_review';

  //ONBOARDING
  Future<void> setOnboardingComplete(bool value) async {
    await _prefs.setBool(_keyOnboardingComplete, value);
  }

  bool isOnboardingComplete() {
    return _prefs.getBool(_keyOnboardingComplete) ?? false;
  }

  //REVIEW PROMPT
  Future<int> increaseLaunchCounter() async {
    final current = _prefs.getInt(_keyAppLaunchCount) ?? 0;
    final updated = current + 1;
    await _prefs.setInt(_keyAppLaunchCount, updated);
    return updated;
  }

  int getLaunchCount() {
    return _prefs.getInt(_keyAppLaunchCount) ?? 0;
  }

  Future<void> setReviewShown(bool value) async {
    await _prefs.setBool(_keyReviewShown, value);
  }

  bool isReviewAlreadyShown() {
    return _prefs.getBool(_keyReviewShown) ?? false;
  }

  //UUID
  Future<void> saveUuid(String uuid) async {
    await _prefs.setString(_keyUuid, uuid);
  }

  String? getUuid() {
    return _prefs.getString(_keyUuid);
  }

  Future<void> clearUuid() async {
    await _prefs.remove(_keyUuid);
  }

  Future<void> setCustomReviewShown(bool value) async {
    await _prefs.setBool(_keyCustomReview, value);
  }

  bool isCustomReviewShown() {
    return _prefs.getBool(_keyCustomReview) ?? false;
  }
}
