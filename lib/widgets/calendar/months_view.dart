/// @Description:
/// @Author: 歪脖子
/// @Date: 2023-11-03 20:26

part of widgets.calendar;

class _CalendarMonths extends StatelessWidget {
  final DateTime date;
  final Widget Function(DateTime value) itemBuilder;

  const _CalendarMonths({
    Key? key,
    required this.date,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 4,
          mainAxisExtent: 50,
        ),
        itemBuilder: (BuildContext context, int index) {
          return itemBuilder(DateTime(date.year, index + 1));
        },
        itemCount: 12,
      ),
    );
  }
}

class _CalendarMonthItem extends StatelessWidget {
  final DateTime date;
  final bool isSome;
  final bool isSelected;
  final void Function()? onTap;

  const _CalendarMonthItem({
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
          Tools.dateFromMS(date.millisecondsSinceEpoch, pattern: 'M月'),
          style: TextStyle(fontWeight: !isSome ? FontWeight.normal : null),
        ),
      ),
    );
  }
}
