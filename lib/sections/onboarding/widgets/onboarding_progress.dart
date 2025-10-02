import 'package:flutter/material.dart';

import '../../../common/themes/app_palette.dart';
import '../../../common/themes/app_spacing.dart';

class OnboardingProgress extends StatelessWidget {
  final int currentIndex;
  final int total;

  const OnboardingProgress({
    super.key,
    required this.currentIndex,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: context.spacing.size4 * 2,
          height: context.spacing.size4 * 2,
          decoration: BoxDecoration(
            color: isActive
                ? context.palette.blueColor
                : context.palette.lavender,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}
