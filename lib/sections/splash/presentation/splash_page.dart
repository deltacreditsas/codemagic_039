import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io' show Platform;

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../home/presentation/home_page.dart';
import '../providers/splash_notifier.dart';
import '../providers/survey_notifier.dart';
import '../presentation/survey_flow.dart';

class SplashPage extends StatefulWidget {
  static const String id = 'id_splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashNotifier>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    String imagePlatform = 'assets/images/custom_app_store_splash.png';
    Platform.isAndroid
        ? imagePlatform = 'assets/images/custom_play_store_splash.png'
        : imagePlatform = 'assets/images/custom_app_store_splash.png';

    return Consumer<SplashNotifier>(
      builder: (context, splash, _) {
        if (splash.state == SplashState.showSurvey) {
          return ColoredBox(
            color: Colors.white,
            child: Center(
              child: Image.asset(imagePlatform, width: 140.w, height: 140.h),
            ),
          );
        } else {
          return const ColoredBox(color: Colors.white);
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.read<SplashNotifier>().addListener(() {
      final state = context.read<SplashNotifier>().state;

      if (state == SplashState.showSurvey) {
        FlutterNativeSplash.remove();
        _showSurveyPopup();
      }

      if (state == SplashState.navigateHome) {
        FlutterNativeSplash.remove();
        context.go('/${HomePage.id}');
      }
    });
  }

  void _showSurveyPopup() {
    final surveyNotifier = context.read<SurveyNotifier>();

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ChangeNotifierProvider.value(
        value: surveyNotifier,
        child: const SurveyFlow(),
      ),
    );
  }
}
