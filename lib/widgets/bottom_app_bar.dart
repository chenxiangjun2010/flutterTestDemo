part of widgets;

class CustomBottomAppBar extends StatelessWidget {
  final Color? color;
  final Widget child;

  const CustomBottomAppBar({
    Key? key,
    required this.child,
    this.color,
  }) : super(key: key);

  EdgeInsets get _padding {
    return const EdgeInsets.symmetric(
      horizontal: AppTheme.margin,
      vertical: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? BottomAppBarTheme.of(context).color,
      ),
      child: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        minimum: _padding,
        child: child,
      ),
    );
  }
}
