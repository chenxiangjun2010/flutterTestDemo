part of widgets;

class CustomCellGroup extends StatelessWidget {
  final List<Widget> children;
  final Widget? title;
  final Widget? more;
  final double? minHeight;
  final EdgeInsets? padding;
  final bool showDivider;
  final bool isInset;

  const CustomCellGroup({
    Key? key,
    this.children = const [],
    this.minHeight,
    this.showDivider = true,
    this.isInset = true,
    this.title,
    this.more,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final ws = <Widget>[];
    for (var index = 0; index < children.length; index++) {
      if (index != 0 && showDivider) ws.add(const Divider(height: 0.5));
      ws.add(children[index]);
    }
    Widget child = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: ws,
    );
    if (isInset) {
      child = CustomCard(
        padding: EdgeInsets.zero,
        child: child,
      );
    } else {
      child = ColoredBox(
        color: colorScheme.surface,
        child: child,
      );
    }
    if (title != null || more != null) {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            top: false,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ).copyWith(bottom: 5),
              child: DefaultTextStyle.merge(
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (title != null) title!,
                    if (more != null) Flexible(child: more!),
                  ],
                ),
              ),
            ),
          ),
          child,
        ],
      );
    }
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: isInset,
      removeRight: isInset,
      child: _CellTheme(
        padding: padding,
        minHeight: minHeight ?? 50,
        child: child,
      ),
    );
  }
}

class CustomCell extends StatelessWidget {
  final Widget title;
  final Widget? value;
  final bool? showArrow;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final TextStyle? labelStyle;
  final EdgeInsets? padding;
  final void Function()? onTap;

  const CustomCell({
    Key? key,
    required this.title,
    this.value,
    this.showArrow,
    this.onTap,
    this.titleStyle,
    this.valueStyle,
    this.labelStyle,
    this.padding,
  }) : super(key: key);

  factory CustomCell.input(
      {Key? key,
      required Widget title,
      TextEditingController? controller,
      String? hintText,
      TextInputType? keyboardType,
      List<TextInputFormatter>? formatters,
      Widget? suffix,
      bool readOnly,
      ValueChanged<String>? onChanged,
      void Function()? onTap}) = _CellWithInput;

  @override
  Widget build(BuildContext context) {
    final cellTheme = _CellTheme.maybeOf(context);
    final colorScheme = Theme.of(context).colorScheme;
    final ws = <Widget>[];
    ws.add(DefaultTextStyle.merge(
      style: TextStyle(
        fontSize: 17,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w400,
      ).merge(titleStyle),
      child: title,
    ));
    if (value != null) {
      ws.add(const SizedBox(width: 10));
      ws.add(Expanded(
        child: Align(
          alignment: Alignment.centerRight,
          child: DefaultTextStyle.merge(
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 17,
              color: colorScheme.onSecondary,
            ).merge(valueStyle),
            child: value!,
          ),
        ),
      ));
    } else {
      ws.add(const Spacer());
    }
    if (showArrow == true || (onTap != null && showArrow == null)) {
      ws.add(const SizedBox(width: 5));
      ws.add(Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: colorScheme.onSecondary,
      ));
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: SafeArea(
        top: false,
        bottom: false,
        minimum: padding ??
            cellTheme?.padding ??
            const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: AppTheme.margin,
            ),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: cellTheme?.minHeight ?? 0),
          child: Row(children: ws),
        ),
      ),
    );
  }
}

class _CellWithInput extends CustomCell {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? formatters;
  final Widget? suffix;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  // final ValueChanged<String>? onTap;
  @override
  final Function()? onTap;

  _CellWithInput(
      {super.key,
      required super.title,
      this.controller,
      this.hintText,
      this.keyboardType,
      this.formatters,
      this.suffix,
      this.readOnly = false,
      this.onChanged,
      this.onTap})
      : super(
          padding: const EdgeInsets.only(left: AppTheme.margin),
          value: _CellWithInputChild(
            controller: controller,
            hintText: hintText,
            keyboardType: keyboardType,
            formatters: formatters,
            suffix: suffix,
            readOnly: readOnly,
            onChanged: onChanged,
          ),
        );
}

class _CellWithInputChild extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? formatters;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  GestureTapCallback? onTap;
  TapRegionCallback? onTapOutside;

  _CellWithInputChild({
    Key? key,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.formatters,
    this.suffix,
    this.readOnly = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.right,
      keyboardType: keyboardType,
      // minLines: 2,
      // maxLines: 5,
      inputFormatters: formatters,
      readOnly: readOnly,
      onTap: onTap,
      onTapOutside: onTapOutside,
      style: TextStyle(
        fontSize: 17,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        isCollapsed: true,
        isDense: true,
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        suffixIcon: suffix != null
            ? DefaultTextStyle.merge(
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 14, left: 10),
                  child: suffix,
                ),
              )
            : null,
        suffixIconConstraints: const BoxConstraints(),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        disabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        errorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class _CellTheme extends InheritedModel {
  final EdgeInsets? padding;
  final double? minHeight;

  const _CellTheme({
    required super.child,
    this.padding,
    this.minHeight,
  });

  static _CellTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_CellTheme>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  @override
  bool updateShouldNotifyDependent(
    covariant InheritedModel oldWidget,
    Set dependencies,
  ) {
    if (dependencies.contains('padding')) return true;
    if (dependencies.contains('minHeight')) return true;
    return false;
  }
}
