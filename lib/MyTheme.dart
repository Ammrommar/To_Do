import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = Color(0xff5D9CEC);
  static Color whiteColor = Color(0xffFFFFFF);
  static Color blackColor = Color(0xff383838);
  static Color grayColor = Color(0xffb6b6b6);
  static Color greenColor = Color(0xff61E757);
  static Color redColor = Color(0xffEC4B4B);
  static Color backgroundColor = Color(0xffDFECDB);
  static Color backgroundColorDark = Color(0xff060E1E);
  static Color blackDarkColor = Color(0xff141922);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: MyTheme.whiteColor),
      backgroundColor: primaryColor,
      elevation: 0,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      titleMedium: TextStyle(
        color: blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      titleSmall: TextStyle(
        color: blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: whiteColor, elevation: 0),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: primaryColor,
      elevation: 0,
      unselectedItemColor: grayColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      sizeConstraints: const BoxConstraints(minHeight: 70, minWidth: 70),
      elevation: 0,
      backgroundColor: primaryColor,
      shape: StadiumBorder(
        side: BorderSide(color: whiteColor, width: 4),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColorDark,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: MyTheme.blackDarkColor),
      backgroundColor: primaryColor,
      elevation: 0,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: blackDarkColor,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      titleMedium: TextStyle(
        color: blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      titleSmall: TextStyle(
        color: blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: blackDarkColor, elevation: 0),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: primaryColor,
      elevation: 0,
      unselectedItemColor: grayColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      sizeConstraints: BoxConstraints(minHeight: 70, minWidth: 70),
      elevation: 0,
      backgroundColor: primaryColor,
      shape: StadiumBorder(
        side: BorderSide(color: blackDarkColor, width: 4),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
    ),
  );
}
