
import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Ubuntu',
  primaryColor: const Color(0xFF530074),
  primaryColorLight: const Color(0xFFCBCACA),
  primaryColorDark: const Color(0xFF530074),
  scaffoldBackgroundColor: const Color(0xFF010d15),
  cardColor: const Color(0xff0c131e),

  shadowColor: const Color(0xFF4a5361),
  canvasColor: const Color(0xff132131),

  secondaryHeaderColor: const Color(0xFF8797AB),
  disabledColor: const Color(0xFF484848),
  brightness: Brightness.dark,
  hintColor: const Color(0xFF7F7C7C),
  focusColor: const Color(0xFF383838),
  hoverColor: const Color(0xFFABA9A7),
  timePickerTheme: const TimePickerThemeData(backgroundColor: Color(0xFF10324a)),
  datePickerTheme: const DatePickerThemeData(backgroundColor: Color(0xff530074)),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFE4E3E3),
    onPrimary: Color(0xFF044f05),
    onSecondary: Color(0xff530074),
    secondary: Color(0xFF033969),
    onSecondaryContainer: Color(0xFF3E9665),
      tertiary: Color(0xffe78c35)).copyWith(surface: const Color(0xFF010d15)).copyWith(error: const Color(0xFFdd3135),
  ),

  dividerTheme: const DividerThemeData(thickness: 0.5),
);
