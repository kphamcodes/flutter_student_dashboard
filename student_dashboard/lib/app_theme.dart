import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorPalette {
  static const obsidian = Color.fromARGB(255, 42, 42, 42);
  static const seashell = Color.fromARGB(255, 249, 245, 237);
  static const denim = Color.fromARGB(255, 94, 131, 174);
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.merriweatherSans().fontFamily,
    scaffoldBackgroundColor: ColorPalette.seashell,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: ColorPalette.denim,
      onPrimary: ColorPalette.seashell,
      secondary: ColorPalette.obsidian,
      onSecondary: ColorPalette.seashell,
      error: Colors.red,
      onError: ColorPalette.seashell,
      surface: ColorPalette.seashell,
      onSurface: ColorPalette.obsidian,
    ),
    textTheme: GoogleFonts.merriweatherSansTextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1F1F1F),
      hintStyle: const TextStyle(color: ColorPalette.seashell),
      labelStyle: const TextStyle(color: ColorPalette.seashell),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(
          color: Color(0xFF3A3A3A),
          width: 1.2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: ColorPalette.denim, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.red, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      errorStyle: const TextStyle(
        color: Colors.red,
        fontSize: 10,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      isDense: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorPalette.denim,
        foregroundColor: ColorPalette.seashell,
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}
