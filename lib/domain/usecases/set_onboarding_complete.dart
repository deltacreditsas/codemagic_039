import '../repositories/preferences_repository.dart';

class SetOnboardingComplete {
  final PreferencesRepository _repo;

  SetOnboardingComplete(this._repo);

  Future<void> call(bool value) async {
    await _repo.setOnboardingComplete(value);
  }
}
