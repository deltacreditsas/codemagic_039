import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/di/service_locator.dart';
import '../domain/usecases/is_onboarding_complete.dart';
import '../sections/home/presentation/home_page.dart';
import '../sections/legals/policy/presentation/policy_page.dart';
import '../sections/legals/terms/presentation/terms_page.dart';
import '../sections/onboarding/presentation/onboarding_page.dart';
import '../sections/splash/presentation/splash_page.dart';
import '../sections/splash/providers/splash_notifier.dart';
import '../sections/webview/presentation/browser_page.dart';

final router = GoRouter(
  initialLocation: '/${SplashPage.id}',
  routes: [
    GoRoute(
      path: '/${SplashPage.id}',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => SplashNotifier(),
          child: const SplashPage(),
        );
      },
    ),

    GoRoute(
      path: '/${OnboardingPage.id}',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/${HomePage.id}',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/${PolicyPage.id}',
      builder: (context, state) => const PolicyPage(),
    ),
    GoRoute(
      path: '/${TermsPage.id}',
      builder: (context, state) => const TermsPage(),
    ),
    GoRoute(
      path: '/${BrowserPage.id}',
      pageBuilder: (context, state) {
        final url = state.extra;
        return MaterialPage(
          key: state.pageKey,
          child: BrowserPage(extra: url),
        );
      },
    ),
  ],
  redirect: (context, state) {
    final location = state.matchedLocation;

    if (location == '/${SplashPage.id}') {
      return '/${SplashPage.id}';
    }

    final isOnboardingComplete = getIt<IsOnboardingComplete>()();

    if (!isOnboardingComplete) {
      return '/${OnboardingPage.id}';
    }

    return null;
  },
);
