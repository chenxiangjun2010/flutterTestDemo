part of widgets;

class CustomRadioGroup<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final int rowCount;
  final bool shrink;
  final double spacing;
  final Widget Function(int index, T item, bool isSelected) builder;
  final ValueChanged<T?>? onChanged;

  const CustomRadioGroup({
    Key? key,
    this.items = const [],
    this.value,
    required this.builder,
    this.rowCount = 1,
    this.spacing = 10,
    this.onChanged,
    this.shrink = false,
  }) : super(key: key);

  @override
  State<CustomRadioGroup<T>> createState() => _CustomRadioGroupState<T>();
}

class _CustomRadioGroupState<T> extends State<CustomRadioGroup<T>> {
  T? _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomRadioGroup<T> oldWidget) {
    _value = widget.value;
    super.didUpdateWidget(oldWidget);
  }

  void _changeValue(T value) {
    setState(() {
      _value = value;
    });
    widget.onChanged?.call(_value);
  }

  @override
  Widget build(BuildContext context) {
    return _CheckboxGroupLayout(
      length: widget.items.length,
      rowCount: widget.rowCount,
      spacing: widget.spacing,
      builder: (int index, BoxConstraints constraints) {
        final item = widget.items[index];
        final isSelected = _value == item;
        return SizedBox(
          width: !widget.shrink ? constraints.maxWidth : null,
          child: GestureDetector(
            onTap: () => _changeValue(item),
            child: widget.builder(index, item, isSelected),
          ),
        );
      },
    );
  }
}

class CustomCheckboxGroup<T> extends StatefulWidget {
  final List<T> items;
  final List<T> values;
  final int? maxCount;
  final int rowCount;
  final bool shrink;
  final bool useCell;
  final double spacing;
  final Widget Function(int index, T item, bool isSelected) builder;
  final ValueChanged<List<T>>? onChanged;

  const CustomCheckboxGroup({
    Key? key,
    this.items = const [],
    this.values = const [],
    this.maxCount,
    required this.builder,
    this.rowCount = 1,
    this.spacing = 10,
    this.onChanged,
    this.shrink = false,
    this.useCell = false,
  }) : super(key: key);

  @override
  State<CustomCheckboxGroup<T>> createState() => _CustomCheckboxGroupState<T>();
}

class _CustomCheckboxGroupState<T> extends State<CustomCheckboxGroup<T>> {
  late List<T> _values;

  int get _maxCount => widget.maxCount ?? widget.items.length;

  @override
  void initState() {
    _values = [...widget.values];
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomCheckboxGroup<T> oldWidget) {
    _values = [...widget.values];
    super.didUpdateWidget(oldWidget);
  }

  int _getCurrentIndex(T value) {
    return _values.indexWhere((element) => element == value);
  }

  void _changeValue(T value, bool isSelected) {
    setState(() {
      if (isSelected) {
        _values.remove(value);
      } else {
        if (_values.length >= _maxCount) return;
        _values.add(value);
      }
    });
    widget.onChanged?.call(_values);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (widget.useCell) {
      return CustomCellGroup(
        children: List.generate(widget.items.length, (index) {
          final item = widget.items[index];
          final isSelected = _getCurrentIndex(item) > -1;
          return CustomCell(
            onTap: () => _changeValue(item, isSelected),
            showArrow: false,
            title: widget.builder(index, item, isSelected),
            value: CustomAnimatedSwitcher(
              child: Icon(
                key: ValueKey(isSelected),
                isSelected ? Icons.check_circle_rounded : Icons.circle,
                size: 24,
                color: isSelected ? colorScheme.primary : colorScheme.tertiary,
              ),
            ),
          );
        }),
      );
    }
    return _CheckboxGroupLayout(
      length: widget.items.length,
      rowCount: widget.rowCount,
      spacing: widget.spacing,
      builder: (int index, BoxConstraints constraints) {
        final item = widget.items[index];
        final isSelected = _getCurrentIndex(item) > -1;
        return SizedBox(
          width: !widget.shrink ? constraints.maxWidth : null,
          child: GestureDetector(
            onTap: () => _changeValue(item, isSelected),
            child: widget.builder(index, item, isSelected),
          ),
        );
      },
    );
  }
}

class CustomChoose extends StatelessWidget {
  final bool value;
  final Widget child;
  final void Function()? onTap;

  const CustomChoose({
    super.key,
    required this.child,
    this.value = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        decoration: BoxDecoration(
          color: Color.alphaBlend(
            colorScheme.primary.withOpacity(value ? 0.2 : 0.04),
            colorScheme.surface,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: DefaultTextStyle.merge(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: value ? colorScheme.primary : colorScheme.onSurface,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _CheckboxGroupLayout extends StatelessWidget {
  final double spacing;
  final int length;
  final int rowCount;
  final Widget Function(int index, BoxConstraints constraints) builder;

  const _CheckboxGroupLayout({
    Key? key,
    required this.length,
    required this.builder,
    required this.spacing,
    required this.rowCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final margin = (rowCount - 1) * spacing;
        final width = (constraints.maxWidth - margin) / rowCount;
        return Wrap(
          runSpacing: spacing,
          spacing: spacing,
          children: List.generate(length, (index) {
            return builder(
              index,
              BoxConstraints(
                minHeight: 0,
                minWidth: 0,
                // maxHeight: constraints.maxHeight,
                maxWidth: width,
              ),
            );
          }),
        );
      },
    );
  }
}
