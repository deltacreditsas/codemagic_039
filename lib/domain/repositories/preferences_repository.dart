abstract class PreferencesRepository {
  // Onboarding
  Future<void> setOnboardingComplete(bool value);
  bool isOnboardingComplete();

  // Review
  Future<int> increaseLaunchCounter();
  int getLaunchCount();
  Future<void> setReviewShown(bool value);
  bool isReviewAlreadyShown();

  // UUID
  Future<void> saveUuid(String uuid);
  String? getUuid();
  Future<void> clearUuid();

  // Custom Review
  Future<void> setCustomReviewShown(bool value);
  bool isCustomReviewShown();
}
