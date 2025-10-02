import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../common/themes/app_spacing.dart';
import '../../../common/themes/app_typography.dart';
import '../../../common/widgets/custom_info_card.dart';
import '../../../domain/entities/onboarding_step.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingStep step;

  const OnboardingContent({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey(step.title),
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16),
            child: CustomInfoCard(
              child: Image.asset(
                step.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),

        SizedBox(height: context.spacing.size32),
        Text(
          step.title.tr(),
          style: context.typography.bold40,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.spacing.size16),
        Text(
          step.subtitle.tr(),
          style: context.typography.normal16,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
