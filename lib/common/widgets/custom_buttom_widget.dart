import 'package:flutter/material.dart';
import '../themes/app_spacing.dart';
import '../themes/app_typography.dart';

import '../themes/app_palette.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? action;
  final String label;

  const CustomButton({super.key, required this.action, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all<TextStyle>(
          context.typography.bold22White,
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
          context.palette.orangeColor,
        ),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
        minimumSize: WidgetStateProperty.all<Size?>(
          Size(double.infinity, context.spacing.inputAndButtonHeight),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              context.spacing.buttonBorderRadius,
            ),
          ),
        ),
      ),

      onPressed: action,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.spacing.size16),
        child: Text(label, style: context.typography.bold22White),
      ),
    );
  }
}

class CustomGradientButton extends StatelessWidget {
  final VoidCallback? action;
  final String label;
  final bool enabled;

  const CustomGradientButton({
    super.key,
    required this.action,
    required this.label,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? action : null,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: enabled
              ? const LinearGradient(
                  colors: [Color(0xFFFF8A00), Color(0xFFFF3D00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(colors: [Colors.grey, Colors.grey]),
        ),
        child: Center(
          child: Text(
            label,
            style: context.typography.bold22White.copyWith(fontSize: 18)
          ),
        ),
      ),
    );
  }
}
