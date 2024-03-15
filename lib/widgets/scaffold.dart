/// @Description: 页面脚手架
/// @Author: 歪脖子
/// @Date: 2023-10-14 12:20

part of widgets;

class CustomScaffoldWithBottomSheet extends StatefulWidget {
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget bottomSheet;
  final Widget? bottomNavigationBar;

  const CustomScaffoldWithBottomSheet({
    super.key,
    this.backgroundColor,
    this.appBar,
    this.body,
    this.bottomNavigationBar,
    required this.bottomSheet,
  });

  @override
  State<CustomScaffoldWithBottomSheet> createState() =>
      _CustomScaffoldWithBottomSheetState();
}

class _CustomScaffoldWithBottomSheetState
    extends State<CustomScaffoldWithBottomSheet> {
  final GlobalKey _navBarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.backgroundColor,
      appBar: widget.appBar,
      body: Stack(
        fit: StackFit.expand,
        children: [
          widget.body ?? const SizedBox(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomSheet(
              navBarKey: _navBarKey,
              child: widget.bottomSheet,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        key: _navBarKey,
        child: widget.bottomNavigationBar,
      ),
    );
  }
}

class _BottomSheet extends StatefulWidget {
  final GlobalKey navBarKey;
  final Widget child;

  const _BottomSheet({
    Key? key,
    required this.child,
    required this.navBarKey,
  }) : super(key: key);

  @override
  State<_BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<_BottomSheet>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  final GlobalKey _childKey = GlobalKey();
  final double _barHeight = 34;
  double _childHeight = 0;
  double _navBarHeight = 0;
  bool _isExpanded = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _childHeight = _childKey.currentContext?.size?.height ?? 0;
      _navBarHeight = widget.navBarKey.currentContext?.size?.height ?? 0;
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get _paddingBottom {
    final bottom = MediaQuery.of(context).viewInsets.bottom - _navBarHeight;
    return bottom < 0 ? 0 : bottom;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.only(bottom: _paddingBottom),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SizedBox(
            height: _barHeight + _childHeight * _controller.value,
            child: child,
          );
        },
        child: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (_isExpanded) {
                  _controller.reverse(from: _controller.value);
                } else {
                  _controller.forward(from: _controller.value);
                }
                _isExpanded = !_isExpanded;
                Tools.unfocus();
              },
              child: Container(
                height: _barHeight,
                alignment: Alignment.center,
                child: Container(
                  height: 6,
                  width: 35,
                  decoration: ShapeDecoration(
                    color: colorScheme.primary,
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
            ),
            Positioned(
              key: _childKey,
              top: _barHeight,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.margin,
                ).copyWith(bottom: 10),
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
