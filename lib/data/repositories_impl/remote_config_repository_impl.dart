import '../../domain/repositories/remote_config_repository.dart';
import '../../integration/firebase_remote.dart';

class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  final FirebaseRemote _firebaseRemote;

  RemoteConfigRepositoryImpl(this._firebaseRemote);

  @override
  int getSurveyChance() {
    return _firebaseRemote.getInt('survey_chance');
  }
}
