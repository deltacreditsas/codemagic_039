import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/app_spacing.dart';
import '../../../core/di/service_locator.dart';
import '../../../domain/usecases/is_onboarding_complete.dart';
import '../../../domain/usecases/set_onboarding_complete.dart';
import '../../home/presentation/home_page.dart';
import '../providers/onboarding_notifier.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/onboarding_controls.dart';
import '../widgets/onboarding_progress.dart';

class OnboardingPage extends StatelessWidget {
  static const String id = 'id_onboarding';

  const OnboardingPage({super.key});

  void _goToHome(BuildContext context) {
    context.go('/${HomePage.id}');
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingNotifier(
        getIt<SetOnboardingComplete>(),
        getIt<IsOnboardingComplete>(),
      ),
      child: Consumer<OnboardingNotifier>(
        builder: (context, notifier, _) {
          return Scaffold(
            body: SafeArea(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity == null) return;
                  final shouldGoHome = notifier.handleSwipe(
                    details.primaryVelocity!,
                  );
                  if (shouldGoHome) {
                    _goToHome(context);
                  }
                },
                child: Column(
                  children: [
                    Expanded(   // 👈 Додаємо тут
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: Tween<double>(
                                begin: 0.95,
                                end: 1.0,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: OnboardingContent(
                          key: ValueKey(notifier.currentStep.title),
                          step: notifier.currentStep,
                        ),
                      ),
                    ),
                    SizedBox(height: context.spacing.size16),
                    OnboardingProgress(
                      currentIndex: notifier.currentIndex,
                      total: notifier.steps.length,
                    ),
                    SizedBox(height: context.spacing.size32),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        context.spacing.size16,
                        0,
                        context.spacing.size16,
                        context.spacing.size40,
                      ),
                      child: OnboardingControls(
                        onNext: () {
                          if (notifier.isLastStep) {
                            notifier.completeOnboarding();
                            _goToHome(context);
                          } else {
                            notifier.nextStep();
                          }
                        },
                      ),
                    ),
                  ],
                ),

              ),
            ),
          );
        },
      ),
    );
  }
}
