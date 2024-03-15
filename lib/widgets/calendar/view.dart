/// @Description: 日历组件
/// @Author: 歪脖子
/// @Date: 2023-11-02 20:11

part of widgets.calendar;

enum CustomCalendarMode { month, day }

class CustomCalendar extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? selected;
  final CustomCalendarMode mode;
  final ValueChanged<DateTime>? onChanged;

  const CustomCalendar({
    super.key,
    this.initialDate,
    this.selected,
    this.mode = CustomCalendarMode.day,
    this.onChanged,
  });

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late final PageController _pageController;
  late DateTime _initialDate;
  late DateTime _currentDate;
  late DateTime _startDate;
  late DateTime _endDate;
  int _monthPage = 0;
  DateTime? _selected;
  _ViewType _viewType = _ViewType.day;

  int get _monthCount => _Utils.monthDelta(_startDate, _endDate);

  @override
  void initState() {
    if (widget.mode == CustomCalendarMode.month) _viewType = _ViewType.month;
    _initialDate = widget.initialDate ?? DateTime.now();
    _selected = widget.selected;
    _currentDate = _selected ?? _initialDate.copyWith();
    _startDate = _initialDate.copyWith(year: _initialDate.year - 20);
    _endDate = _initialDate.copyWith(year: _initialDate.year + 20);
    _monthPage = _Utils.monthDelta(_startDate, _currentDate);
    _pageController = PageController(initialPage: _monthPage);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onActionYear() {
    setState(() {
      if (_viewType == _ViewType.year) {
        if (widget.mode == CustomCalendarMode.month) {
          _viewType = _ViewType.month;
        } else {
          _viewType = _ViewType.day;
        }
      } else {
        _viewType = _ViewType.year;
      }
    });
  }

  void _onActionMonth() {
    setState(() {
      if (_viewType == _ViewType.month) {
        _viewType = _ViewType.day;
      } else {
        _viewType = _ViewType.month;
      }
    });
  }

  void _previousMonth() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void _nextMonth() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void _changeMonth(DateTime value, int page) {
    setState(() {
      _monthPage = page;
      _currentDate = value;
    });
  }

  void _changeMonthFromPicker(DateTime value) {
    if (widget.mode == CustomCalendarMode.month) {
      _viewType = _ViewType.month;
      _selectDate(value);
      return;
    }
    _pageController.jumpToPage(_Utils.monthDelta(_startDate, value));
    setState(() {
      _viewType = _ViewType.day;
    });
  }

  void _changeYearFromPicker(DateTime value) {
    if (widget.mode == CustomCalendarMode.month) {
      setState(() {
        _currentDate = value;
        _viewType = _ViewType.month;
      });
      return;
    }

    final count = _Utils.monthDelta(
      _startDate,
      value.copyWith(month: _currentDate.month),
    );
    final page = count > 0 ? count : 0;
    _pageController.jumpToPage(page < _monthCount ? page : _monthCount);
    setState(() {
      _viewType = _ViewType.day;
    });
  }

  void _selectDate(DateTime value) {
    setState(() {
      _selected = value;
    });
    widget.onChanged?.call(_selected!);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    final narrowWeekdays = localizations.narrowWeekdays;
    return LayoutBuilder(
      builder: (context, constraints) {
        final rowsHeight = constraints.maxWidth / narrowWeekdays.length;
        final viewHeight = rowsHeight * _Utils.maxRowCount;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _CalendarAction(
              date: _currentDate,
              mode: widget.mode,
              viewType: _viewType,
              onYear: _onActionYear,
              onMonth: _onActionMonth,
              onPrevious: _monthPage > 0 ? _previousMonth : null,
              onNext: _monthPage < _monthCount ? _nextMonth : null,
            ),
            Flexible(
              child: SizedBox(
                height: viewHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (widget.mode == CustomCalendarMode.day)
                      Offstage(
                        offstage: _viewType != _ViewType.day,
                        child: _CalendarDays(
                          controller: _pageController,
                          startDate: _startDate,
                          endDate: _endDate,
                          itemCount: _monthCount,
                          itemBuilder: _buildDayItem,
                          onMonthChanged: _changeMonth,
                        ),
                      ),
                    Visibility(
                      visible: _viewType == _ViewType.month,
                      child: _CalendarMonths(
                        date: _currentDate,
                        itemBuilder: _buildMonthItem,
                      ),
                    ),
                    Visibility(
                      visible: _viewType == _ViewType.year,
                      child: _CalendarYears(
                        height: viewHeight,
                        date: _selected != null ? _selected! : _initialDate,
                        startDate: _startDate,
                        endDate: _endDate,
                        itemBuilder: _buildYearItem,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildYearItem(DateTime value) {
    return _CalendarYearItem(
      date: value,
      isSome: _Utils.isSomeYear(_initialDate, value),
      isSelected: _Utils.isSomeYear(_selected, value),
      onTap: () => _changeYearFromPicker(value),
    );
  }

  Widget _buildMonthItem(DateTime value) {
    final isDisabled = value.isBefore(_startDate.copyWith(day: 1)) ||
        value.isAfter(_endDate.copyWith(day: 1));
    return _CalendarMonthItem(
      date: value,
      isSome: _Utils.isSomeMonth(_initialDate, value),
      isSelected: _Utils.isSomeMonth(_selected, value),
      onTap: !isDisabled ? () => _changeMonthFromPicker(value) : null,
    );
  }

  Widget _buildDayItem(DateTime value) {
    final isDisabled = value.isBefore(_startDate) || value.isAfter(_endDate);
    return _CalendarDayItem(
      date: value,
      isSome: _Utils.isSomeDay(_initialDate, value),
      isSelected: _Utils.isSomeDay(_selected, value),
      onTap: !isDisabled ? () => _selectDate(value) : null,
    );
  }
}
