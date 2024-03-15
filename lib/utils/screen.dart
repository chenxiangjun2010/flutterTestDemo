part of utils;

abstract class Screen {
  static MediaQueryData get mediaQuery => MediaQueryData.fromView(
        PlatformDispatcher.instance.views.first,
      );

  /// 获取屏幕宽度
  static double get width => mediaQuery.size.width;

  /// 获取屏幕高度
  static double get height => mediaQuery.size.height;

  /// 获取屏幕dp比例
  static double get scale => mediaQuery.devicePixelRatio;

  /// 获取顶部安全区域
  static double get statusBar => mediaQuery.padding.top;

  /// 获取底部安全区域
  static double get bottomBar => mediaQuery.padding.bottom;

  /// 是否是平板
  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.shortestSide > 600;
  }
}
