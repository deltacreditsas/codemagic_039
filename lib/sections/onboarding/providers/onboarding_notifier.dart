import 'package:flutter/material.dart';
import '../../../domain/entities/onboarding_step.dart';
import '../../../domain/usecases/is_onboarding_complete.dart';
import '../../../domain/usecases/set_onboarding_complete.dart';

class OnboardingNotifier extends ChangeNotifier {
  final SetOnboardingComplete _setOnboardingComplete;
  final IsOnboardingComplete _isOnboardingComplete;

  OnboardingNotifier(
      this._setOnboardingComplete,
      this._isOnboardingComplete,
      );

  bool get isComplete => _isOnboardingComplete();

  final List<OnboardingStep> steps = [
    const OnboardingStep(
      image: 'assets/images/step_1.png',
      title: 'onboarding.step1.title',
      subtitle: 'onboarding.step1.subtitle',
    ),
    const OnboardingStep(
      image: 'assets/images/step_2.png',
      title: 'onboarding.step2.title',
      subtitle: 'onboarding.step2.subtitle',
    ),
  ];

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;
  OnboardingStep get currentStep => steps[_currentIndex];

  bool get isLastStep => _currentIndex == steps.length - 1;
  bool get isFirstStep => _currentIndex == 0;

  void nextStep() {
    if (!isLastStep) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (!isFirstStep) {
      _currentIndex--;
      notifyListeners();
    }
  }


  Future<void> completeOnboarding() async {
    await _setOnboardingComplete(true);
    notifyListeners();
  }


  bool handleSwipe(double velocity) {
    if (velocity < 0) {
      if (isLastStep) {
        completeOnboarding();
        return true;
      } else {
        nextStep();
      }
    } else if (velocity > 0) {
      previousStep();
    }
    return false;
  }

  void reset() {
    _currentIndex = 0;
    notifyListeners();
  }
}
