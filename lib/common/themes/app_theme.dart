import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_palette.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData standart = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    extensions: [
      const AppPalette(
        backgroundColor: Color(0xFFFFFFFF),
        blueColor: Color(0xFF2084FF),
        whiteColor: Color(0xFFFFFFFF),
        orangeColor: Color(0xFFFF651A),
        semiBlueColor: Color(0xFFDCE3FF),
        lavender: Color(0xFFF0F3FF),
        blackColor: Color(0xFF22203C),
      ),
      AppSpacing(
        size4: 4.0.r,
        size10: 10.0.r,
        size12: 12.0.r,
        size16: 16.0.r,
        size20: 20.0.r,
        size25: 25.0.r,
        size32: 32.0.r,
        size40: 40.0.r,
        borderRadius: 16.0.r,
        buttonBorderRadius: 40.0.r,
        inputAndButtonHeight: 60.0.r,
      ),
      AppTypography(
        bold40: GoogleFonts.sora(
          fontSize: 40.sp,
          fontWeight: FontWeight.w700,
          height: 48 / 48,
          color: const Color(0xFF22203C),
        ),
        bold36: GoogleFonts.sora(
          fontSize: 36.sp,
          fontWeight: FontWeight.w700,
          height: 44 / 36,
          color: const Color(0xFF22203C),
        ),
        bold28: GoogleFonts.sora(
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
          height: 34 / 28,
          color: const Color(0xFF22203C),
        ),
        semiBold24: GoogleFonts.sora(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          height: 28 / 24,
          color: const Color(0xFF22203C),
        ),
        semiBold24Blue: GoogleFonts.sora(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          height: 28 / 24,
          color: const Color(0xFF2084FF),
        ),
        bold22White: GoogleFonts.sora(
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          height: 28 / 20,
          color: const Color(0xFFFFFFFF),
        ),
        semiBold20: GoogleFonts.sora(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          height: 24 / 20,
          color: const Color(0xFF22203C),
        ),
        semiBold18: GoogleFonts.sora(
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
          height: 20 / 17,
          color: const Color(0xFF22203C),
        ),
        bold16: GoogleFonts.sora(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          height: 22 / 16,
          color: const Color(0xFF22203C),
        ),
        normal16: GoogleFonts.sora(
          fontSize: 16.sp,
          fontWeight: FontWeight.w300,
          height: 20 / 16,
          color: const Color(0xFF22203C),
        ),
        bold14: GoogleFonts.sora(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          height: 20 / 14,
          color: const Color(0xFF22203C),
        ),
        semiBold10: GoogleFonts.sora(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          height: 10 / 14,
          color: const Color(0xFF22203C),
        ),

      ),
    ],
  );
}
