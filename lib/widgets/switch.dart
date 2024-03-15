part of widgets;

class CustomSwitch extends StatefulWidget {
  final bool value;
  final bool enable;
  final ValueChanged<bool>? onChanged;

  const CustomSwitch({
    super.key,
    this.value = false,
    this.enable = true,
    this.onChanged,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool _value = false;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomSwitch oldWidget) {
    _value = widget.value;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: _value,
      activeColor: AppTheme.success.withOpacity(widget.enable ? 1 : 0.5),
      trackColor: Theme.of(context).colorScheme.tertiary,
      onChanged: (value) {
        if (!widget.enable) return;
        setState(() {
          _value = value;
        });
        widget.onChanged?.call(_value);
      },
    );
  }
}
