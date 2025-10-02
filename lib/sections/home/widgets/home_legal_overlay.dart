import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/themes/app_palette.dart';
import '../../../common/themes/app_spacing.dart';
import '../../../common/themes/app_typography.dart';
import '../../legals/policy/presentation/policy_page.dart';
import '../../legals/terms/presentation/terms_page.dart';
import '../providers/home_notifier.dart';

class HomeLegalOverlay extends StatelessWidget {
  const HomeLegalOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final uiState = context.read<HomeUiState>();

    return Stack(
      children: [
        Positioned.fill(
          child: InkWell(
            onTap: () => uiState.closeLegal(),
            child: Container(
              color: context.palette.blackColor.withValues(alpha: 0.6),
            ),
          ),
        ),
        Positioned(
          top: context.spacing.size32 * 2,
          right: context.spacing.size16,
          child: Container(
            height: 80.h,
            width: 200.w,
            decoration: BoxDecoration(
              color: context.palette.whiteColor,
              borderRadius: BorderRadius.circular(context.spacing.size16),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: context.spacing.size16,
                vertical: context.spacing.size12,
              ),
              itemCount: 2,
              itemBuilder: (context, index) {
                final icons = [
                  'assets/images/terms_security.svg',
                  'assets/images/privacy_document.svg',
                ];
                final texts = ['privacy.title'.tr(), 'terms.title'.tr()];
                final routers = ['/${PolicyPage.id}', '/${TermsPage.id}'];

                return GestureDetector(
                  onTap: () => context.go(routers[index]),
                  child: Row(
                    children: [
                      SvgPicture.asset(icons[index], width: 20.w, height: 20.h),
                      SizedBox(width: context.spacing.size12),
                      Text(texts[index], style: context.typography.bold14),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  Divider(thickness: 1, color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }
}
