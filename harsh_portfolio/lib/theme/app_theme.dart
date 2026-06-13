import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF1A1A2E),
    scaffoldBackgroundColor: const Color(0xFFFAFAFC),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1A1A2E),
      secondary: Color(0xFF6C63FF),
      surface: Color(0xFFFFFFFF),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1A1A2E),
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE8E8EE)),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFFFAFAFC).withValues(alpha: 0.9),
      foregroundColor: const Color(0xFF1A1A2E),
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF6C63FF),
    scaffoldBackgroundColor: const Color(0xFF0A0A0F),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6C63FF),
      secondary: Color(0xFF8B83FF),
      surface: Color(0xFF151520),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFFFFFFF),
      onSurface: Color(0xFFE8E8EE),
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF2A2A3E)),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF0A0A0F).withValues(alpha: 0.9),
      foregroundColor: const Color(0xFFE8E8EE),
      elevation: 0,
    ),
  );
}
