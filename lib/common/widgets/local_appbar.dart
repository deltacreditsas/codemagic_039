import 'package:flutter/material.dart';
import '../../common/themes/app_palette.dart';
import '../../common/themes/app_typography.dart';

PreferredSizeWidget simpleCustomAppBar({
  required BuildContext context,
  required String title,
  required VoidCallback onBack,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    leading: IconButton(
      onPressed: onBack,
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: context.palette.blackColor,
      ),
    ),
    centerTitle: true,
    title: Text(
      title,
      style: context.typography.bold22White.copyWith(
        color: context.palette.blackColor,
      ),
    ),
  );
}
