import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/repositories/preferences_repository.dart';

enum SplashState { idle, showSurvey, navigateHome }

class SplashNotifier extends ChangeNotifier {
  SplashState state = SplashState.idle;
  final prefs = GetIt.instance<PreferencesRepository>();

  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 500));

      // Android: Simple flow - go straight to home
      state = SplashState.navigateHome;

    notifyListeners();
  }
}
