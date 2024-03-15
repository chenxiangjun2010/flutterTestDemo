/// @Description:
/// @Author: 歪脖子
/// @Date: 2023-11-03 20:26

part of widgets.calendar;

class _CalendarAction extends StatelessWidget {
  final DateTime date;
  final CustomCalendarMode mode;
  final _ViewType viewType;
  final void Function()? onPrevious;
  final void Function()? onNext;
  final void Function()? onYear;
  final void Function()? onMonth;

  const _CalendarAction({
    Key? key,
    required this.date,
    required this.viewType,
    this.onPrevious,
    this.onNext,
    this.onYear,
    this.onMonth,
    required this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomButton(
            type: CustomButtonType.borderless,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            fontSize: 16,
            onPressed: onYear,
            child: Row(
              children: [
                Text(Tools.dateFromMS(
                  date.millisecondsSinceEpoch,
                  pattern: 'yyyy年',
                )),
                AnimatedRotation(
                  turns: viewType == _ViewType.year ? 0.5 : 0,
                  duration: const Duration(milliseconds: 150),
                  child: const Icon(Icons.keyboard_arrow_down_rounded),
                ),
              ],
            ),
          ),
          if (mode == CustomCalendarMode.day)
            CustomButton(
              type: CustomButtonType.borderless,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              fontSize: 16,
              onPressed: onMonth,
              child: Row(
                children: [
                  Text(Tools.dateFromMS(
                    date.millisecondsSinceEpoch,
                    pattern: 'M月',
                  )),
                  AnimatedRotation(
                    turns: viewType == _ViewType.month ? 0.5 : 0,
                    duration: const Duration(milliseconds: 150),
                    child: const Icon(Icons.keyboard_arrow_down_rounded),
                  ),
                ],
              ),
            ),
          const Spacer(),
          Visibility(
            visible:
                viewType == _ViewType.day && mode == CustomCalendarMode.day,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton(
                  type: CustomButtonType.borderless,
                  padding: EdgeInsets.zero,
                  width: 25,
                  fontSize: 24,
                  onPressed: onPrevious,
                  child: const Icon(Icons.chevron_left_rounded),
                ),
                const SizedBox(width: 10),
                CustomButton(
                  type: CustomButtonType.borderless,
                  padding: EdgeInsets.zero,
                  width: 25,
                  fontSize: 24,
                  onPressed: onNext,
                  child: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
