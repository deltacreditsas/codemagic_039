import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/app_spacing.dart';
import '../../../core/di/service_locator.dart';
import '../../../domain/usecases/preload_webview.dart';
import '../../../integration/engagement_rate.dart';
import '../../../common/const/const_key.dart';
import '../providers/home_notifier.dart';
import '../widgets/home_bottom_card.dart';
import '../widgets/home_legal_overlay.dart';
import '../widgets/home_steps.dart';
import '../widgets/home_top_bar.dart';

class HomePage extends StatefulWidget {
  static const String id = 'id_home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // iOS: Preload webview with Firebase params
      if (Platform.isIOS) {
        await getIt<PreloadWebView>().call(ConstKey.urlWV);
        await getIt<EngagementRate>().maybeShowReview();
      }
      // Android: Preload webview without Firebase params
      else {
        await getIt<PreloadWebView>().call(ConstKey.urlANDRWV);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeUiState(),
      child: Consumer<HomeUiState>(
        builder: (context, uiState, _) {
          return Scaffold(
            body: Stack(
              children: [
                SafeArea(
                  minimum: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: context.spacing.size25),
                        HomeTopBar(),
                        SizedBox(height: context.spacing.size32),
                        HomeSteps(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: context.spacing.size20),
                  child: const HomeBottomCard(),
                ),

                if (uiState.showLegalButton) const HomeLegalOverlay(),
              ],
            ),
          );
        },
      ),
    );
  }
}
