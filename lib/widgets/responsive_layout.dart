/// @Description: 响应式布局
/// @Author: 歪脖子
/// @Date: 2023-11-06 17:38

part of widgets;

class CustomResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;

  const CustomResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
  });

  @override
  Widget build(BuildContext context) {
    if (Screen.isTablet(context) && tablet != null) return tablet!;
    return mobile;
  }
}
