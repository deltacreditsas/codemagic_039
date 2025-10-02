import 'package:flutter/material.dart';

class AppTypography extends ThemeExtension<AppTypography> {
  final TextStyle bold40;
  final TextStyle bold36;
  final TextStyle bold28;
  final TextStyle semiBold24;
  final TextStyle semiBold24Blue;
  final TextStyle bold22White;
  final TextStyle semiBold20;
  final TextStyle semiBold18;
  final TextStyle bold16;
  final TextStyle normal16;
  final TextStyle bold14;
  final TextStyle semiBold10;

  const AppTypography({
    required this.bold40,
    required this.bold36,
    required this.bold28,
    required this.semiBold24,
    required this.semiBold24Blue,
    required this.bold22White,
    required this.semiBold20,
    required this.semiBold18,
    required this.bold16,
    required this.normal16,
    required this.bold14,
    required this.semiBold10,
  });

  @override
  AppTypography copyWith({
    TextStyle? bold40,
    TextStyle? bold36,
    TextStyle? bold28,
    TextStyle? semiBold24,
    TextStyle? semiBold24Blue,
    TextStyle? bold22White,
    TextStyle? semiBold20,
    TextStyle? semiBold18,
    TextStyle? bold16,
    TextStyle? normal16,
    TextStyle? bold14,
    TextStyle? semiBold10,
  }) {
    return AppTypography(
      bold40: bold40 ?? this.bold40,
      bold36: bold36 ?? this.bold36,
      bold28: bold28 ?? this.bold28,
      semiBold24: semiBold24 ?? this.semiBold24,
      semiBold24Blue: semiBold24Blue ?? this.semiBold24Blue,
      bold22White: bold22White ?? this.bold22White,
      semiBold20: semiBold20 ?? this.semiBold20,
      semiBold18: semiBold18 ?? this.semiBold18,
      bold16: bold16 ?? this.bold16,
      normal16: normal16 ?? this.normal16,
      bold14: bold14 ?? this.bold14,
      semiBold10: semiBold10 ?? this.semiBold10,
    );
  }

  @override
  AppTypography lerp(ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) return this;
    return this;
  }
}

extension AppTypographyExtension on BuildContext {
  AppTypography get typography => Theme.of(this).extension<AppTypography>()!;
}
