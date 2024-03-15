import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:xiaoerban_business/global.dart';
import 'package:xiaoerban_business/routes/index.dart';
import 'package:xiaoerban_business/store/index.dart';
import 'package:xiaoerban_business/theme.dart';
import 'package:xiaoerban_business/widgets/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Global.init().then((_) {
    Future.wait([
      UserStore.to.profile(),
      ShopStore.to.initSettings(),
    ]).whenComplete(() {
      runApp(const MyApp());
      //FlutterNativeSplash.remove();
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '清源水务项目管理平台',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      routerConfig: Routes.config,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale.fromSubtags(languageCode: 'en'),
        Locale.fromSubtags(languageCode: 'zh'),
      ],
      locale: PlatformDispatcher.instance.locale,
      builder: CustomToast.init(
        context: context,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: _NoShadowScrollBehavior(),
            child: child ?? const Material(),
          );
        },
      ),
    );
  }
}

class _NoShadowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return child;
      case TargetPlatform.android:
        return GlowingOverscrollIndicator(
          showLeading: false,
          showTrailing: false,
          axisDirection: details.direction,
          color: Theme.of(context).colorScheme.primary,
          child: child,
        );
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return GlowingOverscrollIndicator(
          showLeading: false,
          showTrailing: false,
          axisDirection: details.direction,
          color: Theme.of(context).colorScheme.primary,
          child: child,
        );
    }
  }
}
