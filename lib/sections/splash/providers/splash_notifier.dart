import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../../core/di/service_locator.dart';
import '../../../domain/repositories/preferences_repository.dart';
import '../../../domain/repositories/remote_config_repository.dart';
import '../../../domain/usecases/init_push_notifications.dart';
import '../../../integration/engagement_rate.dart';

final _log = Logger();

enum SplashState { idle, showSurvey, navigateHome }

class SplashNotifier extends ChangeNotifier {
  SplashState state = SplashState.idle;
  final prefs = GetIt.instance<PreferencesRepository>();

  Future<void> init() async {
    //Remote Config
    final rcRepo = getIt<RemoteConfigRepository>();
    // Prefs
    final chance = rcRepo.getSurveyChance();

    await Future.delayed(const Duration(milliseconds: 500));

    await getIt<InitPushNotifications>()();

    final shouldShowSurvey = !prefs.isCustomReviewShown();

    final randomNumber = (DateTime.now().millisecondsSinceEpoch % 100) + 1;
    _log.i('Random roll = $randomNumber (chance = $chance)');

    await getIt<EngagementRate>().registerLaunch();

    if (shouldShowSurvey && (randomNumber <= chance)) {
      state = SplashState.showSurvey;
    } else {
      state = SplashState.navigateHome;
    }

    notifyListeners();
  }
}
