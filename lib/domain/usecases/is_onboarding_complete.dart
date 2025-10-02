import '../repositories/preferences_repository.dart';

class IsOnboardingComplete {
  final PreferencesRepository _repo;

  IsOnboardingComplete(this._repo);

  bool call() {
    return _repo.isOnboardingComplete();
  }
}
