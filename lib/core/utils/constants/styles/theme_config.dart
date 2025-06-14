import 'package:flutter/material.dart';

import 'app_colors.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.blackCherry,
  appBarTheme: const AppBarTheme(
    color: AppColors.blackCherry,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontFamily: 'Exo2',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.07,
    ),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    },
  ),
);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.placebo,
  appBarTheme: const AppBarTheme(
    color: AppColors.placebo,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: AppColors.blackCherry,
      fontFamily: 'Exo2',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.07,
    ),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    },
  ),
);

