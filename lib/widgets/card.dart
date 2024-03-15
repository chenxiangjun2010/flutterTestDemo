part of widgets;

class CustomCard extends StatelessWidget {
  final Widget? header;
  final Widget? child;
  final Color? backgroundColor;
  final Color? shadowColor;
  final bool showShadow;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Clip clipBehavior;
  final void Function()? onTap;

  const CustomCard({
    Key? key,
    this.child,
    this.backgroundColor,
    this.shadowColor,
    this.showShadow = false,
    this.width,
    this.height,
    this.onTap,
    this.clipBehavior = Clip.none,
    this.padding,
    this.header,
  }) : super(key: key);

  EdgeInsetsGeometry get _padding => padding ?? const EdgeInsets.all(15);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        clipBehavior: clipBehavior,
        padding: _padding,
        decoration: BoxDecoration(
          color: backgroundColor ?? colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: shadowColor ?? colorScheme.shadow,
                    offset: const Offset(0, 0),
                    blurRadius: 10,
                  ),
                ]
              : null,
        ),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: colorScheme.onSurface),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (header != null)
                Padding(
                  padding: EdgeInsets.only(bottom: _padding.vertical / 2),
                  child: DefaultTextStyle.merge(
                    style: TextStyle(
                      color: colorScheme.onSurface.withOpacity(0.8),
                      fontWeight: FontWeight.w600,
                    ),
                    child: header!,
                  ),
                ),
              if (child != null) Flexible(child: child!),
            ],
          ),
        ),
      ),
    );
  }
}
