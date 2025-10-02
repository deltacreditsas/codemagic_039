import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/themes/app_spacing.dart';
import '../../../common/themes/app_typography.dart';
import '../../../common/widgets/custom_buttom_widget.dart';

class OfflineLayer extends StatelessWidget {
  final VoidCallback onRetry;

  const OfflineLayer({super.key, required this.onRetry});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(context.spacing.size16),
        child: Column(
          children: [

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/image_offline.png',
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: context.spacing.size32),
                  Text(
                    'offline.title'.tr(),
                    style: context.typography.semiBold24,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.spacing.size16),
                  Text(
                    'offline.subtitle'.tr(),
                    style: context.typography.normal16,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: context.spacing.size25),
              child: CustomButton(
                action: onRetry,
                label: 'offline.button'.tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
