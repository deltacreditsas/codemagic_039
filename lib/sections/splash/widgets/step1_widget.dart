import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/app_typography.dart';
import '../../../common/widgets/custom_buttom_widget.dart';
import '../providers/survey_notifier.dart';
import 'survey_container_widget.dart';

class Step1Widget extends StatelessWidget {
  const Step1Widget({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<SurveyNotifier>();

    return SurveyContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'splash.page1.title'.tr(),
            style: context.typography.semiBold20.copyWith(
              fontSize: 22,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('splash.page1.subtitle_1'.tr(),
                  style: context.typography.normal16.copyWith(height: 1.4)),
              const SizedBox(height: 6),
              Text('splash.page1.subtitle_2'.tr(),
                  style: context.typography.normal16.copyWith(height: 1.4)),
              const SizedBox(height: 6),
              Text('splash.page1.subtitle_3'.tr(),
                  style: context.typography.normal16.copyWith(height: 1.4)),
            ],
          ),

          const SizedBox(height: 24),

          CustomGradientButton(
            action: notifier.nextFromStep1,
            label: 'splash.button_get_cash'.tr(),
          ),
        ],
      ),
    );
  }
}
