// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:store_redirect/store_redirect.dart';

import '../../../domain/repositories/preferences_repository.dart';
import '../../home/presentation/home_page.dart';

final _log = Logger();

enum SurveyStep { step1, step2, step3, step4, step5 }

class SurveyNotifier extends ChangeNotifier {
  final _prefs = GetIt.instance<PreferencesRepository>();

  SurveyStep step = SurveyStep.step1;
  int rating = 0;
  String feedback = '';

  bool get shouldShowSurvey => !_prefs.isCustomReviewShown();

  void nextFromStep1() {
    step = SurveyStep.step2;
    notifyListeners();
  }

  void submitRating() {
    if (rating <= 3) {
      step = SurveyStep.step3;
    } else {
      step = SurveyStep.step5;
    }
    notifyListeners();
  }

  void submitFeedback() {
    step = SurveyStep.step4;
    notifyListeners();

  }

  Future<void> redirectToStore(BuildContext context) async {
    try {
      await StoreRedirect.redirect(
        ///TODO Add real aOS bundleID
        androidAppId: '',
        iOSAppId: '6753209133',
      );
    } catch (e) {
      _log.e('⚠️ Store redirect error: $e');
    } finally {
      closeSurvey(context);
    }
  }

  void setRating(int value) {
    rating = value;
    notifyListeners();
  }

  void closeSurvey(BuildContext context) {
    _prefs.setCustomReviewShown(true);
    Navigator.of(context).pop();
    FlutterNativeSplash.remove();
    context.go('/${HomePage.id}');
  }
}
