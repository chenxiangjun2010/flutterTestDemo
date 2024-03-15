/// @Description: 步进器
/// @Author: 歪脖子
/// @Date: 2023-10-16 10:26

part of widgets;

class CustomStepper extends StatefulWidget {
  final int? value;
  final int? min;
  final int? max;
  final ValueChanged<int>? onChanged;

  const CustomStepper({
    super.key,
    this.value,
    this.min,
    this.max,
    this.onChanged,
  });

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int _value = 0;

  @override
  void initState() {
    _initValue();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomStepper oldWidget) {
    _initValue();
    super.didUpdateWidget(oldWidget);
  }

  bool get _canLower {
    if (widget.min == null) return true;
    if (_value > widget.min!) return true;
    return false;
  }

  bool get _canUpper {
    if (widget.max == null) return true;
    if (_value < widget.max!) return true;
    return false;
  }

  void _initValue() {
    if (widget.max != null && (widget.value ?? 0) > widget.max!) {
      _value = widget.max ?? 0;
      return;
    }
    if (widget.min != null && (widget.value ?? 0) < widget.min!) {
      _value = widget.min ?? 0;
      return;
    }
    _value = widget.value ?? 0;
  }

  void _lower() {
    setState(() {
      _value--;
    });
    widget.onChanged?.call(_value);
  }

  void _upper() {
    setState(() {
      _value++;
    });
    widget.onChanged?.call(_value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.horizontal(
            left: Radius.circular(15),
            right: Radius.circular(2),
          )),
          child: CustomButton(
            width: 34,
            height: 30,
            fontSize: 22,
            shape: CustomButtonShape.square,
            padding: const EdgeInsets.only(left: 3),
            onPressed: _canLower ? _lower : null,
            child: const Icon(Icons.remove),
          ),
        ),
        const SizedBox(width: 2),
        Container(
          height: 30,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          constraints: const BoxConstraints(minWidth: 40),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            _value.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              color: Theme.of(context).colorScheme.onBackground,
              fontFamily: 'number',
            ),
          ),
        ),
        const SizedBox(width: 2),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.horizontal(
            right: Radius.circular(15),
            left: Radius.circular(2),
          )),
          child: CustomButton(
            width: 34,
            height: 30,
            fontSize: 22,
            shape: CustomButtonShape.square,
            padding: const EdgeInsets.only(right: 3),
            onPressed: _canUpper ? _upper : null,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
