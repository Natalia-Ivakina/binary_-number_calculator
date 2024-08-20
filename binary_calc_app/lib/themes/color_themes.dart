import 'package:flutter/material.dart';

class CustomTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 231, 230, 227), // body, body drawer
      onSecondary: Color.fromARGB(255, 229, 225, 218), // r buttons
      error: Colors.red, //error
      secondaryFixedDim: Color.fromARGB(255, 190, 215, 220), //sq buttons
      onPrimaryContainer:
          Color.fromARGB(255, 86, 85, 78), //body appBar, header drawer
      outlineVariant: Color.fromARGB(255, 49, 54, 63), //font buttons
      inversePrimary: Color.fromARGB(255, 82, 76, 66), //icons on body
      onPrimary: Colors.white, //body field
      secondary: Color.fromARGB(255, 49, 54, 63), //font about
      surface: Color.fromARGB(255, 49, 54, 63), //field font
      onSurface:
          Color.fromARGB(255, 231, 230, 227), //font header drawer, font appBar
      onError: Color.fromARGB(0, 0, 0, 0),
      onSecondaryFixedVariant:
          Color.fromARGB(255, 86, 85, 78), //drawer body font, icons
      outline: Color.fromARGB(255, 217, 214, 214), //pp button
    ),
  );

  static final ThemeData blueTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 182, 187, 196), // body, body drawer
      onSecondary: Color.fromARGB(255, 49, 48, 77), // r buttons
      error: Colors.red,
      secondaryFixedDim: Color.fromARGB(255, 19, 75, 112), //sq buttons
      onPrimaryContainer:
          Color.fromARGB(255, 22, 26, 48), //body appBar, header drawer
      outlineVariant: Color.fromARGB(255, 227, 244, 244), //font buttons
      inversePrimary: Color.fromARGB(255, 55, 66, 89), //icons on body
      onPrimary: Color.fromARGB(255, 245, 237, 237), //body field
      secondary: Color.fromARGB(255, 49, 54, 63), //font about
      surface: Color.fromARGB(255, 49, 54, 63), //field font
      onSurface:
          Color.fromARGB(255, 182, 187, 196), //font header drawer, font appBar
      onError: Color.fromARGB(0, 0, 0, 0), //0
      onSecondaryFixedVariant:
          Color.fromARGB(255, 22, 26, 48), //drawer body font, icons
      outline: Color.fromARGB(255, 165, 150, 232), //pp button
    ),
  );

  static final ThemeData greenTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 200, 220, 206), // body, body drawer
      onSecondary: Color.fromARGB(255, 134, 171, 137), // r buttons
      error: Colors.red,
      secondaryFixedDim: Color.fromARGB(255, 148, 166, 132), //sq buttons
      onPrimaryContainer:
          Color.fromARGB(255, 26, 54, 54), //body appBar, header drawer
      outlineVariant: Color.fromARGB(255, 247, 249, 242), //font buttons
      inversePrimary: Color.fromARGB(255, 54, 85, 65), //icons on body
      onPrimary: Color.fromARGB(255, 245, 237, 237), //body field
      secondary: Color.fromARGB(255, 96, 102, 118), //font about
      surface: Color.fromARGB(255, 96, 102, 118), //field font
      onSurface:
          Color.fromARGB(255, 200, 220, 206), //font header drawer, font appBar
      onError: Color.fromARGB(0, 0, 0, 0), //0
      onSecondaryFixedVariant:
          Color.fromARGB(255, 26, 54, 54), //drawer body font, icons
      outline: Color.fromARGB(255, 211, 245, 214), //pp button
    ),
  );

  static final ThemeData lilacTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 74, 57, 93),
      onSecondary: Color.fromARGB(255, 71, 79, 122), // r buttons
      error: Colors.red,
      secondaryFixedDim: Color.fromARGB(255, 31, 37, 68), //sq buttons
      onPrimaryContainer:
          Color.fromARGB(255, 71, 79, 122), //body appBar, header drawer
      outlineVariant: Color.fromARGB(255, 255, 208, 236), //font buttons
      inversePrimary: Color.fromARGB(255, 255, 208, 236), //icons on body
      onPrimary: Color.fromARGB(255, 245, 237, 237), //body field
      secondary: Color.fromARGB(255, 207, 169, 192), //font about
      surface: Color.fromARGB(255, 31, 37, 68), //field font
      onSurface:
          Color.fromARGB(255, 149, 163, 235), //font header drawer, font appBar
      onError: Color.fromARGB(0, 0, 0, 0), //0
      onSecondaryFixedVariant:
          Color.fromARGB(255, 149, 163, 235), //drawer body font, icons
      outline: Color.fromARGB(255, 197, 189, 251), //pp button
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 63, 66, 77), // body
      onSecondary: Color.fromARGB(255, 109, 114, 129), //  r buttons,
      error: Colors.red, //error
      secondaryFixedDim: Color.fromARGB(255, 107, 114, 142), //sq buttons
      onPrimaryContainer:
          Color.fromARGB(255, 39, 40, 46), //body appBar, header drawer
      outlineVariant: Color.fromARGB(255, 49, 54, 63), //font buttons
      inversePrimary: Color.fromARGB(255, 150, 150, 148), //icons on body
      onPrimary: Color.fromARGB(255, 219, 216, 227), //body field
      secondary: Color.fromARGB(255, 198, 204, 222), //font about
      surface: Color.fromARGB(255, 53, 57, 65), //field font
      onSurface:
          Color.fromARGB(255, 199, 205, 223), //font header drawer, font appBar
      onError: Color.fromARGB(0, 0, 0, 0), //0
      onSecondaryFixedVariant:
          Color.fromARGB(255, 199, 205, 223), //drawer body font, icons
      outline: Color.fromARGB(255, 196, 205, 233), //pp button
    ),
  );
}
