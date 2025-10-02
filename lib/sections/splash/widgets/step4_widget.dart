import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/custom_buttom_widget.dart';
import '../providers/survey_notifier.dart';
import 'rating_stars.dart';
import 'survey_container_widget.dart';

class Step4Widget extends StatelessWidget {
  const Step4Widget({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SurveyNotifier>();

    return SurveyContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'splash.page4.title'.tr(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 12),

          Text(
            'splash.page4.subtitle'.tr(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          RatingStars(
            rating: notifier.rating,
          ),
          const SizedBox(height: 24),

          CustomGradientButton(
            action: () => notifier.closeSurvey(context),
            label: 'splash.button_continue'.tr(),
          ),
        ],
      ),
    );
  }
}
