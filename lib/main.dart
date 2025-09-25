import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'domain/repositories/text_section_repository.dart';
import 'domain/usecases/load_legal_document.dart';
import 'sections/legals/providers/text_section_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final repository = TextSectionRepository();
  final loadPolicyDocument = LoadLegalDocument(repository);

  final provider = TextSectionProvider(loadLegalDocument: loadPolicyDocument);

  await provider.preloadSections('terms', 'assets/texts/terms.yaml');
  await provider.preloadSections('privacy', 'assets/texts/privacy.yaml');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      assetLoader: YamlAssetLoader(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => provider),
        ],
        child: const App(),
      ),
    ),
  );
}
