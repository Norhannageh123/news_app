import 'package:flutter/material.dart';
import 'package:news_app/utls/app_colors.dart';
import 'package:news_app/utls/app_styles.dart';
class AppTheme {
  static final ThemeData lightTheme=ThemeData(
       primaryColor: AppColors.whiteColor,
       appBarTheme:  AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        ),
        textTheme: TextTheme(
          labelLarge: AppStyles.black24Medium,
          headlineLarge: AppStyles.black16bold,
          headlineMedium: AppStyles.black14Medium,
           bodyLarge: AppStyles.black20bold,
            bodyMedium: AppStyles.black24Medium,
        ),
        iconTheme: IconThemeData(
          color:AppColors.blackColor,
        ),
       scaffoldBackgroundColor: AppColors.whiteColor,
       indicatorColor: AppColors.blackColor,
  );
  static final ThemeData darkTheme=ThemeData(
     primaryColor: AppColors.blackColor,
     scaffoldBackgroundColor: AppColors.blackColor,
     appBarTheme:AppBarTheme(
      centerTitle: true,
       backgroundColor: AppColors.blackColor,
      ),
       textTheme: TextTheme(
          labelLarge: AppStyles.white24Medium,
          headlineLarge: AppStyles.white16bold,
          headlineMedium: AppStyles.white14Medium,
          bodyLarge: AppStyles.white20bold,
          bodyMedium: AppStyles.white24Medium,
        ),
        indicatorColor: AppColors.whiteColor,
        iconTheme: IconThemeData(
          color:AppColors.whiteColor,
        ),
  );
}
