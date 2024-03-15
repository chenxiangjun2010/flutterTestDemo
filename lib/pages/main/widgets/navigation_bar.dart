part of pages.main;

class BuildNavigationBar extends StatelessWidget {
  final int currentIndex;
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int>? onTap;

  const BuildNavigationBar({
    super.key,
    this.items = const [],
    required this.currentIndex,
    this.onTap,
  });

  EdgeInsets get _padding {
    return const EdgeInsets.symmetric(vertical: 10)
        .copyWith(bottom: Screen.bottomBar > 0 ? 0 : null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).bottomNavigationBarTheme;
    final ws = <Widget>[];
    for (var index = 0; index < items.length; index++) {
      final item = items[index];
      final labelStyle = currentIndex == index
          ? theme.selectedLabelStyle
          : theme.unselectedLabelStyle;
      final iconStyle = currentIndex == index
          ? theme.selectedIconTheme
          : theme.unselectedIconTheme;
      final color = currentIndex == index
          ? theme.selectedItemColor
          : theme.unselectedItemColor;
      final gap = (items.length / 2).ceil();
      // if (gap == index) ws.add(const SizedBox(width: 65));
      ws.add(Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => onTap?.call(index),
          child: Padding(
            padding: _padding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconTheme(
                  data: (iconStyle ?? const IconThemeData()).copyWith(
                    color: color,
                  ),
                  child: item.icon,
                ),
                DefaultTextStyle.merge(
                  style: labelStyle?.copyWith(color: color),
                  child: Text(item.label ?? '', maxLines: 1),
                ),
              ],
            ),
          ),
        ),
      ));
    }
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      padding: EdgeInsets.zero,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ws,
        ),
      ),
    );
  }
}

class BuildNavigationBarForTablet extends StatelessWidget {
  final int currentIndex;
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int>? onTap;

  const BuildNavigationBarForTablet({
    super.key,
    required this.currentIndex,
    required this.items,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).bottomNavigationBarTheme;
    return SingleChildScrollView(
      child: SafeArea(
        top: false,
        bottom: false,
        minimum: const EdgeInsets.only(bottom: AppTheme.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final labelStyle = currentIndex == index
                ? theme.selectedLabelStyle
                : theme.unselectedLabelStyle;
            final iconStyle = currentIndex == index
                ? theme.selectedIconTheme
                : theme.unselectedIconTheme;
            final color = currentIndex == index
                ? theme.selectedItemColor
                : theme.unselectedItemColor;
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => onTap?.call(index),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconTheme(
                      data: (iconStyle ?? const IconThemeData()).copyWith(
                        color: color,
                      ),
                      child: item.icon,
                    ),
                    DefaultTextStyle.merge(
                      style: labelStyle?.copyWith(color: color),
                      child: Text(item.label ?? '', maxLines: 1),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
