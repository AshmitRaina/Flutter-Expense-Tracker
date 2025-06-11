import 'package:device_preview/device_preview.dart';
import 'package:expense_tracker_revision/screens/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final kLightModeColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 160, 121, 108),
);
final kDarkModeColorScheme = ColorScheme.fromSeed(seedColor: Colors.black);
void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder:
          (context) => MaterialApp(
            useInheritedMediaQuery: true,
            builder: DevicePreview.appBuilder,
            locale: DevicePreview.locale(context),
            darkTheme: ThemeData.dark().copyWith(
              colorScheme: kDarkModeColorScheme,
              brightness: Brightness.dark,
              appBarTheme: const AppBarTheme().copyWith(
                backgroundColor: kDarkModeColorScheme.onSecondaryContainer,
              ),
              textTheme: const TextTheme().copyWith(
                titleLarge: TextStyle(color: kDarkModeColorScheme.onPrimary),

                labelLarge: TextStyle(
                  color: kDarkModeColorScheme.onPrimary,
                  fontSize: 16,
                ),
              ),
              iconButtonTheme: IconButtonThemeData(
                style: IconButton.styleFrom(
                  foregroundColor: kDarkModeColorScheme.onPrimary,
                ),
              ),
              cardTheme:const  CardThemeData().copyWith(
                color: kDarkModeColorScheme.primary,
              ),
              bottomSheetTheme: const BottomSheetThemeData().copyWith(
                backgroundColor: kDarkModeColorScheme.onSecondaryFixed,
              ),
            ),

            theme: ThemeData().copyWith(
              colorScheme: kLightModeColorScheme,
              appBarTheme: const AppBarTheme().copyWith(
                backgroundColor: kLightModeColorScheme.secondaryContainer,
              ),

              iconButtonTheme: IconButtonThemeData(
                style: IconButton.styleFrom(
                  foregroundColor: kLightModeColorScheme.onPrimaryContainer,
                ),
              ),
              textTheme: const TextTheme().copyWith(
                titleLarge: TextStyle(
                  color: kLightModeColorScheme.onSecondaryContainer,
                ),
                titleMedium: TextStyle(
                  color: kLightModeColorScheme.primary,
                  fontSize: 19,
                ),
                titleSmall: TextStyle(color: kLightModeColorScheme.primary),
                labelLarge: TextStyle(
                  color: kLightModeColorScheme.primary,
                  fontSize: 16,
                ),
              ),
              bottomSheetTheme: const BottomSheetThemeData().copyWith(
                backgroundColor: kLightModeColorScheme.onSecondary,
              ),
              iconTheme:const  IconThemeData().copyWith(
                color: kLightModeColorScheme.onPrimaryContainer,
              ),
            ),
            themeMode: ThemeMode.system,
            home:const  HomePage(),
          ),
    ),
  ); //255,188,170,164
}
