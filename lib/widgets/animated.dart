/// @Description: 动画
/// @Author: 歪脖子
/// @Date: 2023-10-25 19:58

part of widgets;

class CustomAnimatedSwitcher extends AnimatedSwitcher {
  CustomAnimatedSwitcher({
    super.key,
    super.duration = const Duration(milliseconds: 150),
    super.child,
  }) : super(
          switchInCurve: Curves.easeInOutCubic,
          switchOutCurve: Curves.easeInOutCubic,
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
}
