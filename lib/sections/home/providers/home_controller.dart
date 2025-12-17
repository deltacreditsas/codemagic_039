import '../../../domain/usecases/compose_url_with_params.dart';
import '../../../domain/usecases/preload_webview.dart';
import '../../../integration/local_identify.dart';

class HomeController {
  final PreloadWebView _preloader;
  final IdentityService _identityService;

  HomeController(
      this._preloader,
      this._identityService,
      );

  Future<void> startPreload(String urlWV) async {
    final url = await composeUrl(urlWV);
    await _preloader.call(url);
  }

  Future<String> composeUrl(String urlWV) async {
    final luid = _identityService.id;

    return composeUrlWithParams(
      urlWV,
      luid: luid,
      overwrite: true,
    );
  }
}
