/// @Description:
/// @Author: 歪脖子
/// @Date: 2023-11-03 20:26

part of widgets.calendar;

class _CalendarDays extends StatelessWidget {
  final PageController controller;
  final DateTime startDate;
  final DateTime endDate;
  final int itemCount;
  final Widget Function(DateTime value) itemBuilder;
  final Function(DateTime value, int page)? onMonthChanged;

  const _CalendarDays({
    Key? key,
    required this.controller,
    required this.startDate,
    required this.endDate,
    required this.itemBuilder,
    required this.itemCount,
    this.onMonthChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemBuilder: (context, index) => _DaysInMonth(
        date: startDate.copyWith(month: startDate.month + index),
        itemBuilder: itemBuilder,
      ),
      itemCount: itemCount + 1,
      onPageChanged: (page) {
        final date = startDate.copyWith(month: startDate.month + page);
        onMonthChanged?.call(date, page);
      },
    );
  }
}

class _CalendarDayItem extends StatelessWidget {
  final DateTime date;
  final bool isSome;
  final bool isSelected;
  final void Function()? onTap;

  const _CalendarDayItem({
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
      padding: const EdgeInsets.all(3),
      child: CustomButton(
        padding: EdgeInsets.zero,
        fontSize: 14,
        type: type,
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        onPressed: onTap,
        child: Text(
          Tools.dateFromMS(date.millisecondsSinceEpoch, pattern: 'd'),
          style: TextStyle(fontWeight: !isSome ? FontWeight.normal : null),
        ),
      ),
    );
  }
}

class _DaysInMonth extends StatelessWidget {
  final DateTime date;
  final Widget Function(DateTime value) itemBuilder;

  const _DaysInMonth({
    Key? key,
    required this.date,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = MaterialLocalizations.of(context);
    final dayCount = _Utils.getDaysInMonth(
      year: date.year,
      month: date.month,
    );
    final offsetCount = _Utils.computeFirstDayOffset(
      year: date.year,
      month: date.month,
      localizations: localizations,
    );
    final days = <int?>[];
    for (var i = 0; i < offsetCount; ++i) {
      days.add(null);
    }
    for (var i = 0; i < dayCount; ++i) {
      days.add(i + 1);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DefaultTextStyle.merge(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: colorScheme.onSecondary,
          ),
          child: Row(
            children: localizations.narrowWeekdays.map((item) {
              return Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Center(child: Text(item)),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            removeLeft: true,
            removeRight: true,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: localizations.narrowWeekdays.length,
              ),
              itemBuilder: (BuildContext context, int index) {
                final item = days[index];
                if (item == null) return const SizedBox.shrink();
                return itemBuilder(DateTime(date.year, date.month, item));
              },
              itemCount: days.length,
            ),
          ),
        ),
      ],
    );
  }
}
