import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: const MaterialColor(
    4287738254,
    {
      50: Color(0xfff0f5f0),
      100: Color(0xffe2eae1),
      200: Color(0xffc4d5c3),
      300: Color(0xffa7c1a4),
      400: Color(0xff8aac86),
      500: Color(0xff6c9768),
      600: Color(0xff577953),
      700: Color(0xff415b3e),
      800: Color(0xff2b3c2a),
      900: Color(0xff161e15)
    },
  ),
  fontFamily: "Sora",
  brightness: Brightness.light,
  primaryColor: const Color(0xff91B18E),
  primaryColorLight: const Color(0xffe2e9e2),
  primaryColorDark: const Color(0xff415b3e),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xffE5E5E5),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w700,
      color: Color(0xff6E906B),
      fontSize: 24,
    ),
    centerTitle: true,
    actionsIconTheme: IconThemeData(color: Color(0xff6D6F7E)),
    iconTheme: IconThemeData(color: Color(0xff6D6F7E)),
  ),
  canvasColor: const Color(0xfffafafa),
  scaffoldBackgroundColor: const Color(0xffE5E5E5),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color(0xffffffff),
  ),
  cardColor: const Color(0xffffffff),
  cardTheme: const CardTheme(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
    ),
  ),
  dividerColor: const Color(0xffCBCCD6),
  highlightColor: const Color(0x66bcbcbc),
  splashColor: const Color(0x66c8c8c8),
  unselectedWidgetColor: const Color(0x8a000000),
  disabledColor: const Color(0x61000000),
  secondaryHeaderColor: const Color(0xffe9f2fc),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff91B18E),
    onPrimary: Color(0xff91B18E),
    secondary: Color(0xff91B18E),
    onSecondary: Color(0xff91B18E),
    error: Color(0xffFF8888),
    background: Color(0xffc6d4c4),
    onError: Color(0xffFF8888),
    onBackground: Color(0xffc6d4c4),
    surface: Color(0xff91B18E),
    onSurface: Color(0xff91B18E),
  ),
  dialogBackgroundColor: const Color(0xffffffff),
  indicatorColor: const Color(0xff70926d),
  hintColor: const Color(0x8a000000),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      side: MaterialStateProperty.all(
        const BorderSide(
          color: Color(0xff91B18E),
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(.5),
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.grey200; // Disabled color
        }
        return const Color(0xff91B18E); // Regular color
      }),
      padding: MaterialStateProperty.all(
        const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      foregroundColor: MaterialStateProperty.all(const Color(0xffffffff)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  ),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    minWidth: 88,
    height: 36,
    padding: EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xff91B18E),
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    alignedDropdown: false,
    buttonColor: Color(0xffe0e0e0),
    disabledColor: Color(0x6106192d),
    highlightColor: Color(0x2906192d),
    splashColor: Color(0x1f06192d),
    focusColor: Color(0x1f06192d),
    hoverColor: Color(0x0a06192d),
    colorScheme: ColorScheme(
      primary: Color(0xff91B18E),
      secondary: Color(0xff91B18E),
      surface: Color(0xffffffff),
      background: Color(0xffc6d4c4),
      error: Color(0xffFF8888),
      onPrimary: Color(0xffffffff),
      onSecondary: Color(0xffffffff),
      onSurface: Color(0xff000000),
      onBackground: Color(0xffffffff),
      onError: Color(0xffffffff),
      brightness: Brightness.light,
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Color(0xff6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    displayMedium: TextStyle(
      color: Color(0xff6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    displaySmall: TextStyle(
      color: Color(0xff6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headlineMedium: TextStyle(
      color: Color(0xff6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headlineSmall: TextStyle(
      color: Color(0xdd6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    titleLarge: TextStyle(
      color: Color(0xdd6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    titleMedium: TextStyle(
      color: Color(0xdd6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    titleSmall: TextStyle(
      color: Color(0x8a6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    bodyLarge: TextStyle(
      color: Color(0xdd6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    bodyMedium: TextStyle(
      color: Color(0x8a6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    bodySmall: TextStyle(
      color: Color(0x8a6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    labelLarge: TextStyle(
      color: Color(0xffF2B062),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    labelSmall: TextStyle(
      color: Color(0xff6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  primaryTextTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    displayMedium: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    displaySmall: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headlineMedium: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headlineSmall: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    titleLarge: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    titleMedium: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    bodyLarge: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    bodyMedium: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    bodySmall: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    labelLarge: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    titleSmall: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    labelSmall: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color(0xff6E906B),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: Color(0xdd6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: Color(0xffD8E5D6),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: Color(0xffFF8888),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: null,
    isDense: false,
    contentPadding: EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 10),
    isCollapsed: false,
    prefixStyle: TextStyle(
      color: Color(0xdd6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: Color(0xdd6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: TextStyle(
      color: Color(0xdd6D6F7E),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    filled: true,
    fillColor: Color(0xffffffff),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xffFF8888),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff91B18E),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff91B18E),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff6D6F7E),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff91B18E),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff91B18E),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
  ),
  //end input
  iconTheme: const IconThemeData(
    color: Color(0xdd91B18E),
    opacity: 1,
    size: 24,
  ),
  primaryIconTheme: const IconThemeData(
    color: Color(0xffffffff),
    opacity: 1,
    size: 24,
  ),
  sliderTheme: const SliderThemeData(
    valueIndicatorTextStyle: TextStyle(
      color: Color(0xffffffff),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Color(0xffffffff),
    unselectedLabelColor: Color(0xb2ffffff),
  ),
  chipTheme: const ChipThemeData(
    backgroundColor: Color(0x1f06192d),
    brightness: Brightness.light,
    deleteIconColor: Color(0xde06192d),
    disabledColor: Color(0x0c06192d),
    labelPadding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
    labelStyle: TextStyle(
      color: Color(0xde06192d),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    padding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
    secondaryLabelStyle: TextStyle(
      color: Color(0x3d06192d),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    secondarySelectedColor: Color(0x3d4caf50),
    selectedColor: Color(0x3d06192d),
    shape: StadiumBorder(
        side: BorderSide(
      color: Color(0xff91B18E),
      width: 0,
      style: BorderStyle.none,
    )),
  ),
  dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
    side: BorderSide(
      color: Color(0xff91B18E),
      width: 0,
      style: BorderStyle.none,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  )),
);
