import '../../../domain/repositories/push_repository.dart';
import '../../../domain/usecases/compose_url_with_params.dart';
import '../../../domain/usecases/preload_webview.dart';
import '../../../integration/firebase_identity.dart';
import '../../../integration/local_identify.dart';

class HomeController {
  final PreloadWebView _preloader;
  final PushRepository _pushRepo;
  final IdentityService _identityService;
  final IdentityManager _identityManager;

  HomeController(
      this._preloader,
      this._pushRepo,
      this._identityService,
      this._identityManager,
      );

  Future<void> startPreload(String urlWV) async {
    final url = await composeUrl(urlWV);
    await _preloader.call(url);
  }

  Future<String> composeUrl(String urlWV) async {
    final psht = await _pushRepo.getToken();
    final luid = _identityService.id;
    final fbuid = await _identityManager.getUid();
    return composeUrlWithParams(
      urlWV,
      psht: psht,
      luid: luid,
      fbuid: fbuid,
      overwrite: true,
    );
  }
}
