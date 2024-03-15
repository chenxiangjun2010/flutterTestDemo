/// @Description:
/// @Author: 歪脖子
/// @Date: 2023-11-03 20:26

part of widgets.calendar;

class _CalendarYears extends StatefulWidget {
  final DateTime date;
  final DateTime startDate;
  final DateTime endDate;
  final double height;
  final Widget Function(DateTime value) itemBuilder;

  const _CalendarYears({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.date,
    required this.height,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  State<_CalendarYears> createState() => _CalendarYearsState();
}

class _CalendarYearsState extends State<_CalendarYears> {
  late final ScrollController _scrollController;

  int get _itemCount => widget.endDate.year - widget.startDate.year + 1;

  double get _scrollOffset {
    final maxScrollExtent = _itemCount ~/ 3 * 50 - widget.height;
    final index = widget.date.year - widget.startDate.year;
    double offset = index ~/ 3 * 50 - (widget.height - 50) / 2;
    if (offset < 0) {
      offset = 0;
    } else if (offset > maxScrollExtent) {
      offset = maxScrollExtent;
    }
    return offset;
  }

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: _scrollOffset);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 0,
          crossAxisSpacing: 10,
          crossAxisCount: 3,
          mainAxisExtent: 50,
        ),
        itemBuilder: (BuildContext context, int index) {
          final item = widget.startDate.year + index;
          return widget.itemBuilder(DateTime(item));
        },
        itemCount: _itemCount,
      ),
    );
  }
}

class _CalendarYearItem extends StatelessWidget {
  final DateTime date;
  final bool isSome;
  final bool isSelected;
  final void Function()? onTap;

  const _CalendarYearItem({
    Key? key,
    required this.date,
    this.isSome = false,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var type = CustomButtonType.borderless;
    var bgColor = Colors.transparent;
    var fgColor = colorScheme.onBackground;
    if (isSome) {
      type = CustomButtonType.opacity;
      fgColor = colorScheme.primary;
    }
    if (isSelected) {
      type = CustomButtonType.filled;
      bgColor = colorScheme.primary;
      fgColor = colorScheme.onPrimary;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: CustomButton(
        padding: EdgeInsets.zero,
        fontSize: 16,
        type: type,
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        onPressed: onTap,
        child: Text(
          Tools.dateFromMS(date.millisecondsSinceEpoch, pattern: 'yyyy'),
          style: TextStyle(fontWeight: !isSome ? FontWeight.normal : null),
        ),
      ),
    );
  }
}
