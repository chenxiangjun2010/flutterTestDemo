/// @Description: 小窗弹出层
/// @Author: 歪脖子
/// @Date: 2023-10-09 13:55

part of widgets;

enum _ArrowDirection { top, bottom }

class CustomPopup extends StatelessWidget {
  /// 箭头指向
  final GlobalKey? anchorKey;
  final Widget child;
  final Widget content;
  final bool isLongPress;

  const CustomPopup({
    super.key,
    required this.child,
    required this.content,
    this.anchorKey,
    this.isLongPress = false,
  });

  void _show(BuildContext context) {
    final anchor = anchorKey?.currentContext ?? context;
    final renderBox = anchor.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final offset = renderBox.localToGlobal(renderBox.paintBounds.topLeft);
    Navigator.of(context).push(_PopupRoute(
      targetRect: offset & renderBox.paintBounds.size,
      child: content,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPress: isLongPress ? () => _show(context) : null,
      onTapUp: !isLongPress ? (_) => _show(context) : null,
      child: child,
    );
  }
}

class _PopupContent extends StatelessWidget {
  final Widget child;
  final GlobalKey childKey;
  final GlobalKey arrowKey;
  final _ArrowDirection arrowDirection;
  final double arrowHorizontal;

  const _PopupContent({
    Key? key,
    required this.child,
    required this.childKey,
    required this.arrowKey,
    required this.arrowHorizontal,
    this.arrowDirection = _ArrowDirection.top,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          key: childKey,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(vertical: 10).copyWith(
            top: arrowDirection == _ArrowDirection.bottom ? 0 : null,
            bottom: arrowDirection == _ArrowDirection.top ? 0 : null,
          ),
          constraints: const BoxConstraints(minWidth: 50),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          child: child,
        ),
        Positioned(
          top: arrowDirection == _ArrowDirection.top ? 2 : null,
          bottom: arrowDirection == _ArrowDirection.bottom ? 2 : null,
          left: arrowHorizontal,
          child: RotatedBox(
            key: arrowKey,
            quarterTurns: arrowDirection == _ArrowDirection.top ? 2 : 4,
            child: CustomPaint(
              size: const Size(16, 8),
              painter: _TrianglePainter(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  const _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final path = Path();
    paint.isAntiAlias = true;
    paint.color = color;

    path.lineTo(size.width * 0.66, size.height * 0.86);
    path.cubicTo(size.width * 0.58, size.height * 1.05, size.width * 0.42,
        size.height * 1.05, size.width * 0.34, size.height * 0.86);
    path.cubicTo(size.width * 0.34, size.height * 0.86, 0, 0, 0, 0);
    path.cubicTo(0, 0, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width * 0.66, size.height * 0.86,
        size.width * 0.66, size.height * 0.86);
    path.cubicTo(size.width * 0.66, size.height * 0.86, size.width * 0.66,
        size.height * 0.86, size.width * 0.66, size.height * 0.86);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _PopupRoute extends PopupRoute<void> {
  final Rect targetRect;
  final Widget child;

  static const double _margin = 10;
  static final Rect _viewportRect = Rect.fromLTWH(
    _margin,
    Screen.statusBar + _margin,
    Screen.width - _margin * 2,
    Screen.height - Screen.statusBar - Screen.bottomBar - _margin * 2,
  );

  final GlobalKey _childKey = GlobalKey();
  final GlobalKey _arrowKey = GlobalKey();
  double _maxHeight = _viewportRect.height;
  _ArrowDirection _arrowDirection = _ArrowDirection.top;
  double _arrowHorizontal = 0;
  double _scaleAlignDx = 0.5;
  double _scaleAlignDy = 0.5;
  double? _bottom;
  double? _top;
  double? _left;
  double? _right;

  _PopupRoute({
    RouteSettings? settings,
    ImageFilter? filter,
    TraversalEdgeBehavior? traversalEdgeBehavior,
    required this.child,
    required this.targetRect,
  }) : super(
          settings: settings,
          filter: filter,
          traversalEdgeBehavior: traversalEdgeBehavior,
        );

  @override
  Color? get barrierColor => Colors.black.withOpacity(0.05);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Popup';

  @override
  TickerFuture didPush() {
    super.offstage = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final childRect = _getRect(_childKey);
      final arrowRect = _getRect(_arrowKey);
      _calculateArrowOffset(arrowRect, childRect);
      _calculateChildOffset(childRect);
      super.offstage = false;
    });
    return super.didPush();
  }

  Rect? _getRect(GlobalKey key) {
    final currentContext = key.currentContext;
    final renderBox = currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;
    final offset = renderBox.localToGlobal(renderBox.paintBounds.topLeft);
    return offset & renderBox.paintBounds.size;
  }

  // 计算箭头水平位置
  void _calculateArrowOffset(Rect? arrowRect, Rect? childRect) {
    if (childRect == null || arrowRect == null) return;
    // 根据目标和弹出层的中间位置计算距离屏幕左侧的距离
    var leftEdge = targetRect.center.dx - childRect.center.dx;
    final rightEdge = leftEdge + childRect.width;
    leftEdge = leftEdge < _viewportRect.left ? _viewportRect.left : leftEdge;
    // 超出屏幕则减去多余的部分
    if (rightEdge > _viewportRect.right) {
      leftEdge -= rightEdge - _viewportRect.right;
    }
    final center = targetRect.center.dx - leftEdge - arrowRect.center.dx;
    // 不让箭头超出弹窗的Padding
    if (center + arrowRect.center.dx > childRect.width - 15) {
      _arrowHorizontal = center - 15;
    } else if (center < 15) {
      _arrowHorizontal = 15;
    } else {
      _arrowHorizontal = center;
    }

    _scaleAlignDx = (_arrowHorizontal + arrowRect.center.dx) / childRect.width;
  }

  // 计算弹出层位置
  void _calculateChildOffset(Rect? childRect) {
    if (childRect == null) return;
    // 缩放对齐

    // 计算弹窗上下
    final topHeight = targetRect.top - _viewportRect.top;
    final bottomHeight = _viewportRect.bottom - targetRect.bottom;
    final maximum = max(topHeight, bottomHeight);
    _maxHeight = childRect.height > maximum ? maximum : childRect.height;
    if (_maxHeight > bottomHeight) {
      // 在目标上方
      _bottom = Screen.height - targetRect.top;
      _arrowDirection = _ArrowDirection.bottom;
      _scaleAlignDy = 1;
    } else {
      // 在目标下方
      _top = targetRect.bottom;
      _arrowDirection = _ArrowDirection.top;
      _scaleAlignDy = 0;
    }

    // 计算弹窗左右
    final left = targetRect.center.dx - childRect.center.dx;
    final right = left + childRect.width;
    if (right > _viewportRect.right) {
      // 在右方
      _right = _margin;
    } else {
      // 在左方
      _left = left < _margin ? _margin : left;
    }
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return child;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    child = _PopupContent(
      childKey: _childKey,
      arrowKey: _arrowKey,
      arrowHorizontal: _arrowHorizontal,
      arrowDirection: _arrowDirection,
      child: child,
    );
    if (!animation.isCompleted) {
      child = FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          alignment: FractionalOffset(_scaleAlignDx, _scaleAlignDy),
          scale: animation,
          child: child,
        ),
      );
    }
    return Stack(
      children: [
        Positioned(
          left: _left,
          right: _right,
          top: _top,
          bottom: _bottom,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: _viewportRect.width,
              maxHeight: _maxHeight,
            ),
            child: Material(
              type: MaterialType.transparency,
              child: child,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);
}
