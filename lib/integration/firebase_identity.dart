import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

final _logger = Logger();

class AuthBridge {
  final FirebaseAuth _firebase;

  AuthBridge(this._firebase);

  User? get active => _firebase.currentUser;

  Future<User?> anonymousLogin() async {
    final credential = await _firebase.signInAnonymously();
    return credential.user;
  }
}

class IdentityResolver {
  final AuthBridge _bridge;

  IdentityResolver(this._bridge);

  Future<String?> obtainUserId() async {
    try {
      final cached = _bridge.active;
      if (cached != null) return cached.uid;

      final fresh = await _bridge.anonymousLogin();
      return fresh?.uid;
    } catch (err, st) {
      _logger.e("Don't have id", error: err, stackTrace: st);
      return null;
    }
  }
}

class IdentityManager {
  final IdentityResolver _resolver;

  IdentityManager(FirebaseAuth auth)
    : _resolver = IdentityResolver(AuthBridge(auth));

  Future<String?> getUid() => _resolver.obtainUserId();
}
