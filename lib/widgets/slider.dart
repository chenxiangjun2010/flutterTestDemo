/// @Description: 滑块
/// @Author: 歪脖子
/// @Date: 2023-10-14 14:27

part of widgets;

class CustomSlider extends StatefulWidget {
  final double min;
  final double max;
  final double step;
  final double? value;
  final bool showTips;
  final String Function(double value)? tipsFormat;
  final ValueChanged<double>? onChanged;

  const CustomSlider({
    super.key,
    this.min = 0,
    this.max = 100,
    this.step = 1,
    this.showTips = true,
    this.value,
    this.onChanged,
    this.tipsFormat,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider>
    with TickerProviderStateMixin {
  final GlobalKey _containerKey = GlobalKey();
  final double _targetSize = 25;
  late final AnimationController _targetController;
  late final Animation<double> _targetScaleAnimation;
  AnimationController? _tipsController;
  Animation<double>? _tipsOffsetAnimation;
  double _containerLeft = 0;
  double _containerRight = 0;
  Offset _targetOffset = Offset.zero;
  double _value = 0;
  double _step = 1;

  @override
  void initState() {
    _initValue();
    _initStep();
    _containerRight = _targetSize;
    _targetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _targetScaleAnimation = Tween<double>(
      begin: 1,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _targetController,
      curve: Curves.elasticOut,
    ));
    if (widget.showTips) {
      _tipsController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 150),
      );
      _tipsOffsetAnimation = Tween<double>(
        begin: 0,
        end: -5,
      ).animate(CurvedAnimation(
        parent: _targetController,
        curve: Curves.elasticOut,
      ));
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final containerSize = _containerKey.currentContext?.size ?? Size.zero;
      _containerLeft = 0;
      _containerRight = max(containerSize.width - _targetSize, _targetSize);
      _echoOffset();
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomSlider oldWidget) {
    _initValue();
    _initStep();
    _echoOffset();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _targetController.dispose();
    _tipsController?.dispose();
    super.dispose();
  }

  void _initValue() {
    if (widget.value == null) {
      _value = widget.min;
      return;
    }
    if (widget.value! > widget.max) {
      _value = widget.max;
      return;
    }
    _value = widget.value!;
  }

  void _initStep() {
    if (widget.step <= 0) return;
    if (widget.step < widget.min) {
      _step = widget.min;
      return;
    }
    if (widget.step > widget.max) {
      _step = widget.max;
      return;
    }
    _step = widget.step;
  }

  void _echoOffset() {
    final dx = _value / widget.max * _containerRight;
    _targetOffset = Offset(dx, _targetOffset.dy);
  }

  void _calculateValue() {
    final value = (_targetOffset.dx / _containerRight * widget.max).round();
    if (value >= widget.max) {
      _value = value.toDouble();
    } else {
      _value = value - value % _step;
    }
  }

  void _dragUpdate(double deltaDx) {
    var dx = _targetOffset.dx + deltaDx;
    if (dx < _containerLeft) dx = _containerLeft;
    if (dx > _containerRight) dx = _containerRight;
    _targetOffset = Offset(dx, _targetOffset.dy);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            key: _containerKey,
            margin: EdgeInsets.all(_targetSize / 2),
            width: constraints.maxWidth,
            height: 6,
            clipBehavior: Clip.hardEdge,
            decoration: ShapeDecoration(
              color: colorScheme.tertiary,
              shape: const StadiumBorder(),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _targetOffset.dx / _containerRight,
              heightFactor: 1,
              child: ColoredBox(color: colorScheme.primary),
            ),
          ),
          if (_tipsController != null && _tipsOffsetAnimation != null)
            Positioned(
              left: _targetOffset.dx + _targetSize / 2,
              bottom: _targetSize * 1.3,
              child: AnimatedBuilder(
                animation: _tipsOffsetAnimation!,
                builder: (context, child) => Transform.translate(
                  offset: Offset(0, _tipsOffsetAnimation!.value),
                  child: child,
                ),
                child: FadeTransition(
                  opacity: _tipsController!,
                  child: _SliderTips(
                    text: widget.tipsFormat?.call(_value) ??
                        _value.toStringAsFixed(2),
                  ),
                ),
              ),
            ),
          Positioned(
            top: 0,
            bottom: 0,
            left: _targetOffset.dx,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragDown: (value) {
                _targetController.forward();
                _tipsController?.forward();
              },
              onHorizontalDragCancel: () {
                _targetController.reset();
                _tipsController?.reset();
                _echoOffset();
                setState(() {});
                widget.onChanged?.call(_value);
              },
              onHorizontalDragEnd: (value) {
                _targetController.reset();
                _tipsController?.reset();
                _echoOffset();
                setState(() {});
                widget.onChanged?.call(_value);
              },
              onHorizontalDragUpdate: (value) {
                _dragUpdate(value.delta.dx);
                _calculateValue();
                setState(() {});
              },
              child: ScaleTransition(
                scale: _targetScaleAnimation,
                child: Container(
                  width: _targetSize,
                  height: _targetSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.primary,
                    border: Border.all(
                      width: 5,
                      color: colorScheme.surface,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliderTips extends StatelessWidget {
  final String text;

  const _SliderTips({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: Screen.width,
      transform: Matrix4.translationValues(-Screen.width / 2, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          CustomPaint(
            size: const Size(12, 6),
            painter: _TrianglePainter(color: colorScheme.surface),
          ),
        ],
      ),
    );
  }
}
