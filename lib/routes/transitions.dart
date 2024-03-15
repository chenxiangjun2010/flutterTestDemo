/// @Description: 路由动画
/// @Author: 歪脖子
/// @Date: 2023-10-13 13:05

part of routes;

class BottomToTopTransitionPage<T> extends CustomTransitionPage<T> {
  BottomToTopTransitionPage({
    super.key,
    super.name,
    required super.child,
  }) : super(
          opaque: false,
          barrierColor: Colors.black.withOpacity(0.5),
          barrierDismissible: true,
          fullscreenDialog: true,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: CurveTween(curve: Curves.fastOutSlowIn)
                  .animate(animation)
                  .drive<Offset>(
                    Tween(begin: const Offset(0, 1.0), end: Offset.zero),
                  ),
              child: SafeArea(
                bottom: false,
                child: Material(
                  type: MaterialType.transparency,
                  clipBehavior: Clip.hardEdge,
                  shape: Theme.of(context).bottomSheetTheme.shape,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeLeft: true,
                    removeRight: true,
                    child: child,
                  ),
                ),
              ),
            );
          },
        );
}
