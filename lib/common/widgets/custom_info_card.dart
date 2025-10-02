import 'package:flutter/material.dart';
import '../themes/app_palette.dart';
import '../themes/app_spacing.dart';

class CustomInfoCard extends StatelessWidget {
  final Widget child;

  const CustomInfoCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.palette.lavender,
        borderRadius: BorderRadius.circular(context.spacing.size20),
        border: Border.all(color: context.palette.blueColor),
      ),
      child: child,
    );
  }
}
