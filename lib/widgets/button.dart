part of widgets;

enum CustomButtonType { filled, opacity, borderless }

enum CustomButtonSize { large, medium, small }

enum CustomButtonShape { radius, stadium, square }

class CustomButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final CustomButtonType type;
  final CustomButtonSize size;
  final CustomButtonShape shape;
  final double? width;
  final double? height;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
    this.type = CustomButtonType.opacity,
    this.size = CustomButtonSize.medium,
    this.shape = CustomButtonShape.stadium,
    this.width,
    this.height,
    this.padding,
    this.fontSize,
  }) : super(key: key);

  OutlinedBorder? get _shape {
    switch (shape) {
      case CustomButtonShape.stadium:
        return const StadiumBorder();
      case CustomButtonShape.radius:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        );
      case CustomButtonShape.square:
        return const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        );
    }
  }

  EdgeInsetsGeometry? get _padding {
    switch (size) {
      case CustomButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 14, vertical: 14);
      case CustomButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 12);
      case CustomButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 10);
    }
  }

  double? get _fontSize {
    switch (size) {
      case CustomButtonSize.large:
        return 20;
      case CustomButtonSize.medium:
        return 17;
      case CustomButtonSize.small:
        return 14;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontSize: fontSize ?? _fontSize),
          ),
          padding: MaterialStateProperty.all(padding ?? _padding),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            switch (type) {
              case CustomButtonType.filled:
                final color = foregroundColor ?? colorScheme.onPrimary;
                if (states.contains(MaterialState.disabled)) {
                  return colorScheme.onTertiary.withOpacity(0.7);
                }
                return color;
              case CustomButtonType.opacity:
                final color = foregroundColor ?? colorScheme.primary;
                if (states.contains(MaterialState.pressed)) {
                  return Color.alphaBlend(
                    color.withOpacity(0.5),
                    colorScheme.surface,
                  );
                }
                if (states.contains(MaterialState.disabled)) {
                  return colorScheme.onTertiary.withOpacity(0.7);
                }
                return color;
              case CustomButtonType.borderless:
                final color = foregroundColor ?? colorScheme.primary;
                if (states.contains(MaterialState.pressed)) {
                  return Color.alphaBlend(
                    color.withOpacity(0.5),
                    colorScheme.surface,
                  );
                }
                if (states.contains(MaterialState.disabled)) {
                  return colorScheme.onTertiary.withOpacity(0.7);
                }
                return color;
            }
          }),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            switch (type) {
              case CustomButtonType.filled:
                final color = backgroundColor ?? colorScheme.primary;
                if (states.contains(MaterialState.pressed)) {
                  return Color.alphaBlend(
                    color.withOpacity(0.5),
                    colorScheme.surface,
                  );
                }
                if (states.contains(MaterialState.disabled)) {
                  return colorScheme.tertiary;
                }
                return color;
              case CustomButtonType.opacity:
                final color = Color.alphaBlend(
                  (foregroundColor ?? colorScheme.primary).withOpacity(0.1),
                  colorScheme.surface,
                );
                if (states.contains(MaterialState.pressed)) {
                  return Color.alphaBlend(
                    color.withOpacity(0.7),
                    colorScheme.surface,
                  );
                }
                if (states.contains(MaterialState.disabled)) {
                  return colorScheme.tertiary;
                }
                return color;
              case CustomButtonType.borderless:
                return Colors.transparent;
            }
          }),
          side: MaterialStateProperty.resolveWith((states) => BorderSide.none),
          shape: MaterialStateProperty.all(_shape),
        ),
        child: IconTheme.merge(
          data: IconThemeData(size: fontSize ?? _fontSize),
          child: child,
        ),
      ),
    );
  }
}
