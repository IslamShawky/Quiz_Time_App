import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const defaultPadding = 30.0;
const statusBarColor = Color(0xFF004060);
const redColor = Color(0xFFEF5A5A);
const greenColor = Color(0xFF008421);
const yellowColor = Color(0xFFffcc00);

const boxShadowColor = Colors.black26;
const boxBorderColor = Color(0xFFCBCBCB);
const boxBorderWidth = 0.5;
const maxWidgetWidth = 700.0;




class AppTheme {
  //FONT
  static const primaryFont = 'NotoNaskhArabic';

  //COLORS
  static const primaryColor = Colors.blue;
  static const onPrimaryColor = Color(0xfffffefe);
  static const secondaryColor = Colors.deepPurple;
  static const onSecondaryColor = Color(0xfffffefe);
  static const tertiaryColor = Color(0xFF0C6591);
  static const onTertiaryColor = Color(0xfffffefe);
  static const surfaceColor = Color(0xfffffefe);
  static const onSurfaceColor = Color(0xff1A374D);
  static const backgroundColor = Color(0xfffffefe);
  static const onBackgroundColor = Color(0xff1A374D);
  static const errorColor = Color(0xFFff382e);
  static const onErrorColor = Color(0xfffffefe);




  static ThemeData appTheme(double ratio) =>
      ThemeData(
        applyElevationOverlayColor: false,
        cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(),
        // extensions:,
        inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            )),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        pageTransitionsTheme: const PageTransitionsTheme(),
        scrollbarTheme: const ScrollbarThemeData(),
        primaryColor: primaryColor,
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: primaryColor,
            onPrimary: onPrimaryColor,
            primaryContainer: primaryColor,
            onPrimaryContainer: onPrimaryColor,
            secondary: secondaryColor,
            onSecondary: onSecondaryColor,
            secondaryContainer: secondaryColor,
            onSecondaryContainer: onSecondaryColor,
            tertiary: tertiaryColor,
            onTertiary: onTertiaryColor,
            // tertiaryContainer: ,
            // onTertiaryContainer: ,
            error: errorColor,
            onError: onErrorColor,
            background: backgroundColor,
            onBackground: onBackgroundColor,
            surface: surfaceColor,
            onSurface: onSurfaceColor),

        brightness: Brightness.light,
        //
        //
        // primarySwatch: MaterialColor(primary, swatch),
        // primaryColor: Color(value),
        //
        //
        // primaryColor: Color(value),
        // primaryColorDark: Color(value),
        //
        //
        // focusColor: Color(value),
        // hoverColor: Color(value),
        shadowColor: boxShadowColor,
        // canvasColor: Color(value),
        // scaffoldBackgroundColor: Color(value),
        // bottomAppBarColor: Color(value),
        cardColor: onTertiaryColor,
        // dividerColor: Color(value),
        // highColor: Color(value),
        // splashColor: Color(value),
        // selectedRowColor: Color(value),
        unselectedWidgetColor: Colors.white,
        // disabledColor: Color(value),
        // secondaryHeaderColor: Color(value),
        // backgroundColor: Color(value),
        // dialogBackgroundColor: Color(value),
        // indicatorColor: Color(value),
        // hintColor: Color(value),
        // errorColor: Color(value),
        // toggleableActiveColor: Color(value),
        fontFamily: primaryFont,
        typography: Typography(),
        textTheme: const TextTheme(
          displayLarge: TextStyle(),
          //T:57 E:64 P:0
          displayMedium: TextStyle(),
          //T:45 E:52 P:0
          displaySmall: TextStyle(),
          //T:36 E:44 P:0
          headlineLarge: TextStyle(),
          //T:32 E:40 P:0
          headlineMedium: TextStyle(),
          //T:28 E:36 P:0
          headlineSmall: TextStyle(),
          //T:24 E:32 P:0
          titleLarge: TextStyle(),
          //T:22 E:28 P:0
          titleMedium: TextStyle(),
          //T:16 E:24 P:0.15
          titleSmall: TextStyle(),
          //T:14 E:20 P:0.1
          bodyLarge: TextStyle(),
          //T:14 E:20 P:0.1
          bodyMedium: TextStyle(),
          //T:12 E:16 P:0.5
          bodySmall: TextStyle(),
          //T:11 E:16 P:0.5
          labelLarge: TextStyle(),
          //T:16 E:24 P:0.15
          labelMedium: TextStyle(),
          //T:14 E:20 P:0.25
          labelSmall: TextStyle(), //T:12 E:16 P:0.4
        ),
        primaryTextTheme: const TextTheme(),
        iconTheme: const IconThemeData(color: primaryColor, size: 20),
        primaryIconTheme: const IconThemeData(size: 20),
        appBarTheme: const AppBarTheme(),
        bannerTheme: const MaterialBannerThemeData(),
        bottomAppBarTheme: const BottomAppBarTheme(),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          unselectedItemColor: secondaryColor,
        ),
        bottomSheetTheme: const BottomSheetThemeData(),
        buttonBarTheme: const ButtonBarThemeData(),
        buttonTheme: const ButtonThemeData(),
        cardTheme: const CardTheme(),
        checkboxTheme: const CheckboxThemeData(),
        chipTheme: const ChipThemeData(),
        dataTableTheme: const DataTableThemeData(),
        dialogTheme: const DialogTheme(),
        dividerTheme: const DividerThemeData(),
        drawerTheme: const DrawerThemeData(),
        elevatedButtonTheme: const ElevatedButtonThemeData(),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(),
        listTileTheme: const ListTileThemeData(),
        navigationBarTheme: const NavigationBarThemeData(),
        navigationRailTheme: const NavigationRailThemeData(),
        outlinedButtonTheme: const OutlinedButtonThemeData(),
        popupMenuTheme: const PopupMenuThemeData(),
        progressIndicatorTheme: const ProgressIndicatorThemeData(),
        radioTheme: const RadioThemeData(),
        sliderTheme: const SliderThemeData(),
        snackBarTheme: const SnackBarThemeData(),
        switchTheme: const SwitchThemeData(),
        tabBarTheme: const TabBarTheme(),
        textButtonTheme: const TextButtonThemeData(),
        textSelectionTheme: const TextSelectionThemeData(),
        timePickerTheme: const TimePickerThemeData(),
        toggleButtonsTheme: const ToggleButtonsThemeData(),
        tooltipTheme: const TooltipThemeData(),
        expansionTileTheme: const ExpansionTileThemeData(),
      );

}
