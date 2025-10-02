import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/custom_buttom_widget.dart';

class OnboardingControls extends StatelessWidget {
  final VoidCallback onNext;

  const OnboardingControls({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      action: onNext,
      label: 'buttons.start'.tr(),
    );
  }
}
