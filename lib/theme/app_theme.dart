import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary colors from laKost branding
  static const Color primaryBlue = Color(0xFF1A3A5C);       // Deep navy
  static const Color accentCyan = Color(0xFF29B6D9);         // Bright cyan (from logo waves)
  static const Color accentGold = Color(0xFFF5A623);         // Gold/orange (from logo sun)
  static const Color white = Color(0xFFFFFFFF);
  static const Color softWhite = Color(0xFFF5F7FA);
  static const Color darkBg = Color(0xFF0D1F35);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF0D1F35);
  static const Color textGrey = Color(0xFF7A8FA6);
  static const Color notifYellow = Color(0xFFFFC107);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0D1F35), Color(0xFF1A3A5C), Color(0xFF1B5E8C)],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0D1F35), Color(0xFF1A3A5C), Color(0xFF1B5E8C)],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0D1F35), Color(0xFF1A3A5C), Color(0xFF1B5E8C)],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF0F6FF)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF29B6D9), Color(0xFF1A8FAA)],
  );

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        brightness: Brightness.light,
        primary: primaryBlue,
        secondary: accentCyan,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      scaffoldBackgroundColor: softWhite,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          color: white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
