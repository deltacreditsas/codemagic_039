import 'dart:ui';

import 'package:flutter/material.dart';

class AppSpacing extends ThemeExtension<AppSpacing> {
  final double size4;
  final double size10;
  final double size12;
  final double size16;
  final double size20;
  final double size25;
  final double size32;
  final double size40;
  final double borderRadius;
  final double buttonBorderRadius;
  final double inputAndButtonHeight;

  const AppSpacing({
    required this.size4,
    required this.size10,
    required this.size12,
    required this.size16,
    required this.size20,
    required this.size25,
    required this.size32,
    required this.size40,
    required this.borderRadius,
    required this.buttonBorderRadius,
    required this.inputAndButtonHeight,
  });

  @override
  AppSpacing copyWith({
    double? size4,
    double? size10,
    double? size12,
    double? size16,
    double? size20,
    double? size25,
    double? size32,
    double? size40,
    double? borderRadius,
    double? buttonBorderRadius,
    double? inputAndButtonHeight,
  }) {
    return AppSpacing(
      size4: size4 ?? this.size4,
      size10: size10 ?? this.size10,
      size12: size12 ?? this.size12,
      size16: size16 ?? this.size16,
      size20: size20 ?? this.size20,
      size25: size25 ?? this.size25,
      size32: size32 ?? this.size32,
      size40: size40 ?? this.size40,
      borderRadius: borderRadius ?? this.borderRadius,
      buttonBorderRadius: buttonBorderRadius ?? this.buttonBorderRadius,
      inputAndButtonHeight: inputAndButtonHeight ?? this.inputAndButtonHeight,
    );
  }

  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) return this;
    return AppSpacing(
      size4: lerpDouble(size4, other.size4, t)!,
      size10: lerpDouble(size10, other.size10, t)!,
      size12: lerpDouble(size12, other.size12, t)!,
      size16: lerpDouble(size16, other.size16, t)!,
      size20: lerpDouble(size20, other.size20, t)!,
      size25: lerpDouble(size25, other.size25, t)!,
      size32: lerpDouble(size32, other.size32, t)!,
      size40: lerpDouble(size40, other.size40, t)!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
      buttonBorderRadius: lerpDouble(
        buttonBorderRadius,
        other.buttonBorderRadius,
        t,
      )!,
      inputAndButtonHeight: lerpDouble(
        inputAndButtonHeight,
        other.inputAndButtonHeight,
        t,
      )!,
    );
  }
}

extension AppSpacingExtension on BuildContext {
  AppSpacing get spacing => Theme.of(this).extension<AppSpacing>()!;
}
