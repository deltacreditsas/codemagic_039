import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/themes/app_spacing.dart';
import '../../../common/themes/app_typography.dart';
import '../../../common/widgets/custom_buttom_widget.dart';
import '../../../common/widgets/custom_info_card.dart';
import '../../../domain/usecases/open_web.dart';

class HomeBottomCard extends StatelessWidget {
  const HomeBottomCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 840;

    final cardTitleStyle = isSmallScreen
        ? context.typography.semiBold24
        : context.typography.bold28;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing.size16,
          vertical: context.spacing.size16,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: screenHeight * 0.5,
            minHeight: 200.h,
          ),
          child: CustomInfoCard(
            child: Stack(
              children: [
                Image.asset('assets/images/home_card.png'),
                Positioned(
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.only(top: context.spacing.size12),
                    child: Text(
                      'main.card.title'.tr(),
                      style: cardTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.lock_outlined, size: 16),
                          SizedBox(width: 8),
                          Text(
                            'main.card.safe'.tr(),
                            style: context.typography.semiBold10,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.spacing.size20,
                          vertical: context.spacing.size4,
                        ),
                        child: CustomButton(
                          action: () => context.openWeb(),
                          label: 'buttons.main'.tr(),
                        ),
                      ),
                      SizedBox(height: context.spacing.size12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
