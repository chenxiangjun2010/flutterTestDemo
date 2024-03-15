import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xiaoerban_business/utils/index.dart';

abstract class AppTheme {
  static const margin = 16.0;

  static const primary = Color(0xFF3061f2);
  static const primaryNavBarBg = Color(0xFF3155FA);
  static const primaryNavBarText = Color(0xFFFFFFFF);
  // static const primaryNavBarBg = Color(0xFF3061f2);
  // static const primary = Color(0xFFFB7299);
  static const success = Color(0xFF28CE88);
  static const warning = Color(0xFFFFD575);
  static const error = Color(0xFFFA6677);
  static const info = Color(0xFF2FA7FF);

  static ThemeMode mode = ThemeMode.system;

  static SystemUiOverlayStyle get systemStyle => const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      );

  static SystemUiOverlayStyle get systemStyleLight => systemStyle.copyWith(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      );

  static SystemUiOverlayStyle get systemStyleDark => systemStyle.copyWith(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: const Color(0xFF0D0D0D),
        systemNavigationBarIconBrightness: Brightness.light,
      );

  static void setSystemStyle() {
    switch (mode) {
      case ThemeMode.system:
        if (Screen.mediaQuery.platformBrightness == Brightness.dark) {
          SystemChrome.setSystemUIOverlayStyle(systemStyleDark);
        } else {
          SystemChrome.setSystemUIOverlayStyle(systemStyleLight);
        }
        break;
      case ThemeMode.light:
        SystemChrome.setSystemUIOverlayStyle(systemStyleLight);
        break;
      case ThemeMode.dark:
        SystemChrome.setSystemUIOverlayStyle(systemStyleDark);
        break;
    }
  }

  static ThemeData get light {
    final scheme = ColorScheme.light(
      background: const Color(0xFFFAFAFA),
      onBackground: const Color(0xFF333333),
      surface: Colors.white,
      onSurface: const Color(0xFF69788C),
      // onSurface: const Color(0xFF333333),
      primary: primary,
      onPrimary: Colors.white,
      secondary: const Color(0xFF999999),
      onSecondary: const Color(0xFF9A9AA8),
      tertiary: const Color(0xFFF3F4F6),
      onTertiary: const Color(0xFF8D97A6),
      outline: const Color(0xFFEDEDED),
      shadow: const Color(0xFFD0DAD6).withOpacity(0.22),
      error: error,
      onError: Colors.white,
    );
    return _getTheme(scheme);
  }

  static ThemeData get dark {
    final scheme = ColorScheme.dark(
      background: const Color(0xFF0D0D0D),
      onBackground: Colors.white,
      surface: const Color(0xFF252525),
      onSurface: Colors.white,
      primary: primary,
      onPrimary: Colors.white,
      secondary: const Color(0xFFFFB800),
      onSecondary: Colors.white,
      tertiary: const Color(0xFF141414),
      outline: const Color(0xFF252525),
      shadow: const Color(0xFF777777).withOpacity(0.08),
      error: error,
      onError: Colors.white,
    );
    return _getTheme(scheme);
  }

  static ThemeData _getTheme(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: false,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.background,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      dialogTheme: DialogTheme(
        elevation: 0,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: const TextStyle(fontSize: 17),
        backgroundColor: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 0,
        backgroundColor: scheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.background,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 44,
        iconTheme: IconThemeData(
          color: scheme.primary,
          size: 24,
        ),
        titleTextStyle: TextStyle(
          color: scheme.onBackground,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
        toolbarTextStyle: TextStyle(
          color: scheme.onBackground,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontSize: 16,
          color: scheme.onBackground,
          height: 1.2,
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          height: 1.2,
          color: scheme.onBackground,
        ),
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        elevation: 0,
        color: scheme.background,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: scheme.background,
        unselectedItemColor: scheme.onBackground.withOpacity(0.5),
        selectedItemColor: scheme.primary,
        unselectedLabelStyle: const TextStyle(fontSize: 12, height: 1.4),
        selectedLabelStyle: const TextStyle(fontSize: 12, height: 1.4),
        unselectedIconTheme: IconThemeData(
          size: 22,
          color: scheme.onBackground.withOpacity(0.5),
        ),
        selectedIconTheme: IconThemeData(
          size: 22,
          color: scheme.primary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isCollapsed: true,
        isDense: true,
        filled: true,
        fillColor: scheme.surface,
        labelStyle: TextStyle(
          fontSize: 16,
          color: scheme.onSurface,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
        hintStyle: TextStyle(color: scheme.onTertiary),
        helperStyle: TextStyle(
          fontSize: 14,
          color: scheme.onSecondary,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.outline, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.outline, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.outline, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.primary, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: error, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: error, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: scheme.onBackground,
        unselectedLabelColor: scheme.onBackground.withOpacity(0.5),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: scheme.primary,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      dividerColor: scheme.outline,
      dividerTheme: DividerThemeData(
        thickness: 0.5,
        color: scheme.outline,
      ),
      popupMenuTheme: PopupMenuThemeData(
        elevation: 4,
        color: scheme.surface,
        textStyle: TextStyle(
          fontSize: 14,
          color: scheme.onSurface.withOpacity(0.8),
          height: 1.2,
        ),
        position: PopupMenuPosition.over,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
