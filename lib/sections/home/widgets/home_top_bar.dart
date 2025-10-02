import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/app_palette.dart';
import '../../../common/themes/app_typography.dart';
import '../providers/home_notifier.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 840;

    final titleStyle = isSmallScreen
        ? context.typography.bold28
        : context.typography.bold36;

    final uiState = context.read<HomeUiState>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('main.title'.tr(), style: titleStyle),
        GestureDetector(
          onTap: () => uiState.toggleLegal(),
          child: Container(
            width: 30.w,
            height: 50.h,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 3.h),
                  decoration: BoxDecoration(
                    color: context.palette.blackColor,
                    shape: BoxShape.circle,
                  ),
                  width: 4.r,
                  height: 4.r,
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
