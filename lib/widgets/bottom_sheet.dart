/// @Description: 底部弹窗
/// @Author: 歪脖子
/// @Date: 2023-10-16 00:52

part of widgets;

class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Clip clipBehavior;
  final bool isInset;

  const CustomBottomSheet({
    super.key,
    required this.child,
    this.clipBehavior = Clip.hardEdge,
    this.backgroundColor,
    this.isInset = false,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    Clip clipBehavior = Clip.hardEdge,
    Color? backgroundColor,
    bool isInset = false,
  }) async {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      clipBehavior: clipBehavior,
      builder: (context) => CustomBottomSheet(
        backgroundColor: backgroundColor,
        clipBehavior: clipBehavior,
        isInset: isInset,
        child: builder(context),
      ),
    );
  }

  static Future<List<CommoditySKUModel>?> showSKU({
    required BuildContext context,
    String? cover,
    String? name,
    String? code,
    List<CommoditySKUModel> data = const [],
    List<CommoditySpecModel> colors = const [],
    List<CommoditySpecModel> sizes = const [],
  }) async {
    return show<List<CommoditySKUModel>>(
      context: context,
      clipBehavior: Clip.none,
      backgroundColor: Theme.of(context).colorScheme.background,
      builder: (context) => _BottomSheetSKU(
        cover: cover,
        code: code,
        name: name,
        data: data,
        colors: colors,
        sizes: sizes,
        onChanged: Navigator.of(context).pop,
      ),
    );
  }

  static Future<List<CommoditySKUModel>?> showStock({
    required BuildContext context,
    String? cover,
    String? name,
    String? code,
    Future<List<CommoditySKUModel>> Function()? data,
  }) async {
    return show<List<CommoditySKUModel>>(
      context: context,
      clipBehavior: Clip.none,
      backgroundColor: Theme.of(context).colorScheme.background,
      builder: (context) => _BottomSheetStock(
        cover: cover,
        code: code,
        name: name,
        data: data,
        onChanged: Navigator.of(context).pop,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomSheetTheme = Theme.of(context).bottomSheetTheme;
    var shape = bottomSheetTheme.shape;
    if (isInset) {
      shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(25));
    }
    return SafeArea(
      bottom: isInset,
      minimum: EdgeInsets.all(isInset ? AppTheme.margin : 0),
      child: MediaQuery.removePadding(
        removeTop: true,
        removeLeft: true,
        removeRight: true,
        removeBottom: isInset,
        context: context,
        child: Container(
          clipBehavior: clipBehavior,
          decoration: ShapeDecoration(
            shape: shape ??
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            color: backgroundColor ?? bottomSheetTheme.backgroundColor,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _GoodsLayout extends StatelessWidget {
  final String? cover;
  final String? name;
  final String? code;
  final Widget child;
  final void Function()? onRemove;
  final void Function()? onConfirm;

  const _GoodsLayout({
    Key? key,
    required this.child,
    this.cover,
    this.name,
    this.code,
    this.onRemove,
    this.onConfirm,
  }) : super(key: key);

  double get _height {
    final threshold = Screen.height / 1.5;
    return threshold > 400 ? threshold : 400;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: _height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(
              AppTheme.margin,
            ).copyWith(bottom: 20),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 105),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(code ?? ''),
                            const SizedBox(height: 3),
                            Text(
                              name ?? '-',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (onRemove != null)
                        CustomButton(
                          width: 28,
                          height: 28,
                          padding: EdgeInsets.zero,
                          fontSize: 24,
                          foregroundColor: AppTheme.error,
                          onPressed: onRemove,
                          child: const Icon(Icons.remove),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  /**/
                  bottom: -5,
                  width: 90,
                  height: 90,
                  child: CustomImage.network(url: cover ?? ''),
                ),
              ],
            ),
          ),
          const Divider(height: 0.5),
          Expanded(child: child),
          CustomBottomAppBar(
            child: CustomButton(
              type: CustomButtonType.filled,
              onPressed: onConfirm,
              child: const Text('确认'),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomSheetStock extends StatefulWidget {
  final String? cover;
  final String? name;
  final String? code;
  final Future<List<CommoditySKUModel>> Function()? data;
  final ValueChanged<List<CommoditySKUModel>>? onChanged;

  const _BottomSheetStock({
    Key? key,
    this.cover,
    this.name,
    this.code,
    this.data,
    this.onChanged,
  }) : super(key: key);

  @override
  State<_BottomSheetStock> createState() => _BottomSheetStockState();
}

class _BottomSheetStockState extends State<_BottomSheetStock> {
  bool _isLoading = true;
  List<CommoditySKUModel> _skus = [];

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    _skus = await widget.data?.call() ?? [];
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _GoodsLayout(
      cover: widget.cover,
      name: widget.name,
      code: widget.code,
      onConfirm: () => widget.onChanged?.call(_skus),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.margin),
        child: _isLoading
            ? Container(
                height: 200,
                alignment: Alignment.center,
                child: const CustomLoadingIndicator(),
              )
            : CustomCellGroup(
                children: List.generate(_skus.length, (index) {
                  final item = _skus[index];
                  return CustomCell(
                    title: SizedBox(
                      width: 180,
                      child: DefaultTextStyle.merge(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        child: Row(
                          children: [
                            Expanded(child: Text(item.colorName ?? '-')),
                            const SizedBox(width: 15),
                            Expanded(child: Text(item.sizeName ?? '-')),
                          ],
                        ),
                      ),
                    ),
                    value: CustomStepper(
                      value: item.count,
                      onChanged: (value) {
                        setState(() {
                          item.count = value;
                        });
                      },
                    ),
                  );
                }),
              ),
      ),
    );
  }
}

class _BottomSheetSKU extends StatefulWidget {
  final String? cover;
  final String? name;
  final String? code;
  final List<CommoditySKUModel> data;
  final List<CommoditySpecModel> colors;
  final List<CommoditySpecModel> sizes;
  final ValueChanged<List<CommoditySKUModel>>? onChanged;

  const _BottomSheetSKU({
    Key? key,
    this.data = const [],
    this.colors = const [],
    this.sizes = const [],
    this.cover,
    this.name,
    this.code,
    this.onChanged,
  }) : super(key: key);

  @override
  State<_BottomSheetSKU> createState() => _BottomSheetSKUState();
}

class _BottomSheetSKUState extends State<_BottomSheetSKU> {
  CommoditySpecModel? _colorValue;
  List<CommoditySKUModel> _skus = [];

  @override
  void initState() {
    _colorValue = widget.colors.isNotEmpty ? widget.colors.first : null;
    _skus = List.generate(widget.data.length, (index) {
      final item = widget.data[index];
      return item.copyWith();
    });
    super.initState();
  }

  List<CommoditySKUModel> get _sizeSKUs {
    return _skus
        .where((element) => element.colorID == _colorValue?.id)
        .toList();
  }

  int get _total {
    var count = 0;
    for (var item in _skus) {
      count += (item.count ?? 0);
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return _GoodsLayout(
      cover: widget.cover,
      name: widget.name,
      code: widget.code,
      onRemove: _total > 0
          ? () {
              for (var item in _skus) {
                item.count = 0;
              }
              widget.onChanged?.call(_skus);
            }
          : null,
      onConfirm: () => widget.onChanged?.call(_skus),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomRadioGroup<CommoditySpecModel>(
              items: widget.colors,
              value: _colorValue,
              rowCount: 4,
              builder: (index, item, isSelected) {
                return CustomChoose(
                  value: isSelected,
                  child: Text(item.name ?? '-'),
                );
              },
              onChanged: (value) {
                setState(() {
                  _colorValue = value;
                });
              },
            ),
            const SizedBox(height: 20),
            CustomCellGroup(
              key: ValueKey(_colorValue?.id),
              title: const Text('尺码'),
              children: List.generate(_sizeSKUs.length, (index) {
                final item = _sizeSKUs[index];
                return CustomCell(
                  title: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: colorScheme.onSurface,
                      ),
                      children: [
                        TextSpan(text: item.sizeName),
                        TextSpan(
                          text: ' 剩 ${item.stock ?? 0} 件',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  value: CustomStepper(
                    value: item.count,
                    min: 0,
                    onChanged: (value) {
                      setState(() {
                        item.count = value;
                      });
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
