import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app/app.dart';
import 'core/di/service_locator.dart';
import 'domain/repositories/text_section_repository.dart';
import 'domain/usecases/load_legal_document.dart';
import 'firebase_options.dart';
import 'integration/crashlytics_service.dart';
import 'sections/legals/providers/text_section_provider.dart';
import 'sections/splash/providers/splash_notifier.dart';
import 'sections/splash/providers/survey_notifier.dart';

void main() async {
  final wfb = WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CrashlyticsService.init();

  await initDependencies();

  final repository = TextSectionRepository();
  final loadPolicyDocument = LoadLegalDocument(repository);

  final provider = TextSectionProvider(loadLegalDocument: loadPolicyDocument);

  await provider.preloadSections('terms', 'assets/texts/terms.yaml');
  await provider.preloadSections('privacy', 'assets/texts/privacy.yaml');

  await WakelockPlus.enable();

  FlutterNativeSplash.preserve(widgetsBinding: wfb);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      assetLoader: YamlAssetLoader(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => provider),
          ChangeNotifierProvider(create: (_) => SplashNotifier()),

          ChangeNotifierProxyProvider<SplashNotifier, SurveyNotifier>(
            create: (_) => SurveyNotifier(),
            update: (ctx, splash, prev) {
              final notifier = prev ?? SurveyNotifier();
              return notifier;
            },
          ),
        ],
        child: const App(),
      ),
    ),
  );
}
