import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local/prefs_storage.dart';
import '../../data/repositories_impl/preferences_repository_impl.dart';
import '../../data/repositories_impl/push_repository_impl.dart';
import '../../data/repositories_impl/remote_config_repository_impl.dart';
import '../../domain/repositories/preferences_repository.dart';
import '../../domain/repositories/push_repository.dart';
import '../../domain/repositories/remote_config_repository.dart';
import '../../domain/usecases/init_push_notifications.dart';
import '../../domain/usecases/is_onboarding_complete.dart';
import '../../domain/usecases/preload_webview.dart';
import '../../domain/usecases/set_onboarding_complete.dart';
import '../../integration/engagement_rate.dart';
import '../../integration/firebase_identity.dart';
import '../../integration/firebase_push.dart';
import '../../integration/firebase_remote.dart';
import '../../integration/network_observer.dart';
import '../../integration/webview_warmup.dart';
import '../../integration/local_identify.dart';
import '../../sections/home/providers/home_controller.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // SharedPreferences
  final shared = await SharedPreferences.getInstance();

  // Local storage
  final prefsStorage = PrefsStorage(shared);

  //FB Remote
  final fbRemote = await FirebaseRemote.init();
  getIt.registerSingleton<FirebaseRemote>(fbRemote);

  getIt.registerSingleton<RemoteConfigRepository>(
    RemoteConfigRepositoryImpl(getIt<FirebaseRemote>()),
  );

  // Repository
  getIt.registerSingleton<PreferencesRepository>(
    PreferencesRepositoryImpl(prefsStorage),
  );

  // UseCases
  getIt.registerLazySingleton<IsOnboardingComplete>(
    () => IsOnboardingComplete(getIt<PreferencesRepository>()),
  );

  getIt.registerLazySingleton<SetOnboardingComplete>(
    () => SetOnboardingComplete(getIt<PreferencesRepository>()),
  );

  final auth = FirebaseAuth.instance;

  // IdentityManager
  getIt.registerSingleton<IdentityManager>(IdentityManager(auth));

  // low-level wrapper
  final firebasePush = FirebasePush();
  getIt.registerSingleton<FirebasePush>(firebasePush);

  // repo
  getIt.registerSingleton<PushRepository>(PushRepositoryImpl(firebasePush));

  //usecase
  getIt.registerLazySingleton<InitPushNotifications>(
    () => InitPushNotifications(getIt<PushRepository>()),
  );

  final identity = await IdentityService().init();
  getIt.registerSingleton<IdentityService>(identity);

  getIt.registerSingleton<BrowserWarmUp>(BrowserWarmUp());

  getIt.registerLazySingleton<PreloadWebView>(
    () => PreloadWebView(getIt<BrowserWarmUp>()),
  );

  final net = NetworkObserver();
  await net.start();
  getIt.registerSingleton<NetworkObserver>(net);

  getIt.registerLazySingleton<EngagementRate>(
    () => EngagementRate(prefs: getIt<PreferencesRepository>()),
  );

  getIt.registerLazySingleton<HomeController>(
    () => HomeController(
      getIt<PreloadWebView>(),
      getIt<PushRepository>(),
      getIt<IdentityService>(),
      getIt<IdentityManager>(),
    ),
  );
}
