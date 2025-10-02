import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/app_palette.dart';
import '../../../common/themes/app_spacing.dart';
import '../../../common/themes/app_typography.dart';
import '../providers/home_notifier.dart';

class HomeSteps extends StatelessWidget {
  const HomeSteps({super.key});

  @override
  Widget build(BuildContext context) {
    final uiState = context.watch<HomeUiState>();
    final steps = uiState.steps;

    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 840;

    final stepStyle = isSmallScreen
        ? context.typography.semiBold18
        : context.typography.semiBold20;

    return Column(
      children: List.generate(steps.length, (index) {
        final isLast = index == steps.length - 1;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: isSmallScreen ? 14 : 18,
                  backgroundColor: context.palette.lavender,
                  child: Text(
                    '${index + 1}',
                    style: isSmallScreen
                        ? context.typography.semiBold24Blue.copyWith(
                            fontSize: 18,
                          )
                        : context.typography.semiBold24Blue,
                  ),
                ),
                if (!isLast)
                  Dash(
                    direction: Axis.vertical,
                    length: context.spacing.size25,
                    dashLength: context.spacing.size4,
                    dashGap: 4.r,
                    dashColor: Colors.blue,
                  ),
              ],
            ),
            SizedBox(width: context.spacing.size12),
            Padding(
              padding: EdgeInsets.only(top: 5.0.r),
              child: Text(steps[index].tr(), style: stepStyle),
            ),
          ],
        );
      }),
    );
  }
}
