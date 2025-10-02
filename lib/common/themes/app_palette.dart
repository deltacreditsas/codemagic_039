import 'package:flutter/material.dart';

class AppPalette extends ThemeExtension<AppPalette> {
  final Color backgroundColor;
  final Color blueColor;
  final Color whiteColor;
  final Color orangeColor;
  final Color semiBlueColor;
  final Color lavender;
  final Color blackColor;

  const AppPalette({
    required this.backgroundColor,
    required this.blueColor,
    required this.whiteColor,
    required this.orangeColor,
    required this.semiBlueColor,
    required this.lavender,
    required this.blackColor,
  });

  @override
  AppPalette copyWith({
    Color? backgroundColor,
    Color? blueColor,
    Color? whiteColor,
    Color? orangeColor,
    Color? semiBlueColor,
    Color? lavender,
    Color? blackColor,
  }) {
    return AppPalette(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      blueColor: blueColor ?? this.blueColor,
      whiteColor: whiteColor ?? this.whiteColor,
      orangeColor: orangeColor ?? this.orangeColor,
      semiBlueColor: semiBlueColor ?? this.semiBlueColor,
      lavender: lavender ?? this.lavender,
      blackColor: blackColor ?? this.blackColor,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      blueColor: Color.lerp(blueColor, other.blueColor, t)!,
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t)!,
      orangeColor: Color.lerp(orangeColor, other.orangeColor, t)!,
      semiBlueColor: Color.lerp(semiBlueColor, other.semiBlueColor, t)!,
      lavender: Color.lerp(lavender, other.lavender, t)!,
      blackColor: Color.lerp(blackColor, other.blackColor, t)!,
    );
  }
}

extension AppPaletteExtension on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
}
