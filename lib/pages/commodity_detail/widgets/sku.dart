part of pages.commodity_detail;

class BuildSKU extends StatefulWidget {
  final bool readOnly;
  final List<CommoditySpecModel> colors;
  final List<CommoditySpecModel> sizes;
  final List<CommoditySpecModel> colorValues;
  final List<CommoditySpecModel> sizeValues;
  final ValueChanged<List<CommoditySKUModel>>? onChanged;
  final ValueChanged<List<CommoditySpecModel>>? onColorsChanged;
  final ValueChanged<List<CommoditySpecModel>>? onSizesChanged;

  const BuildSKU({
    super.key,
    required this.colors,
    required this.sizes,
    required this.colorValues,
    required this.sizeValues,
    this.onChanged,
    this.onColorsChanged,
    this.onSizesChanged,
    this.readOnly = false,
  });

  @override
  State<BuildSKU> createState() => _BuildSKUState();
}

class _BuildSKUState extends State<BuildSKU> {
  final List<CommoditySKUModel> _skus = [];
  List<CommoditySpecModel> _colorValues = [];
  List<CommoditySpecModel> _sizeValues = [];

  @override
  void initState() {
    _colorValues = widget.colorValues;
    _sizeValues = widget.sizeValues;
    if (_colorValues.isEmpty) _colorValues.add(widget.colors.first);
    if (_sizeValues.isEmpty) _sizeValues.add(widget.sizes.first);
    _generated();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BuildSKU oldWidget) {
    _colorValues = widget.colorValues;
    _sizeValues = widget.sizeValues;
    if (_colorValues.isEmpty) _colorValues.add(widget.colors.first);
    if (_sizeValues.isEmpty) _sizeValues.add(widget.sizes.first);
    _generated();
    super.didUpdateWidget(oldWidget);
  }

  void _generated() {
    final tempSku = [..._skus];
    _skus.clear();
    for (var color in _colorValues) {
      for (var size in _sizeValues) {
        final id = '${color.id}_${size.id}';
        final index = _skus.indexWhere((element) => element.id == id);
        if (index < 0) {
          _skus.add(CommoditySKUModel(
            id: id,
            colorName: color.name,
            colorID: color.id,
            sizeName: size.name,
            sizeID: size.id,
          ));
        }
      }
    }
    for (var i = 0; i < tempSku.length; ++i) {
      final temp = tempSku[i];
      for (var j = 0; j < _skus.length; ++j) {
        final item = _skus[j];
        if (item.id == temp.id) _skus[j] = temp;
      }
    }
    setState(() {});
    widget.onChanged?.call(_skus);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCellGroup(
          title: const Text('规格'),
          more: CustomPopup(
            content: _SKUSelect(
              colors: widget.colors,
              sizes: widget.sizes,
              colorValues: _colorValues,
              sizeValues: _sizeValues,
              onColorsChanged: (values) {
                _colorValues = values;
                _generated();
                widget.onColorsChanged?.call(values);
              },
              onSizesChanged: (values) {
                _sizeValues = values;
                _generated();
                widget.onSizesChanged?.call(values);
              },
            ),
            child: Text(
              '编辑',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: Theme.of(context).textTheme.labelLarge?.fontWeight,
              ),
            ),
          ),
          children: List.generate(_skus.length, (index) {
            final item = _skus[index];
            return CustomCell.input(
              key: ValueKey(item.id),
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
              controller: TextEditingController(
                text: item.stock?.toString() ?? '',
              ),
              readOnly: widget.readOnly,
              suffix: widget.readOnly
                  ? const CustomPopup(
                      content: Text('请前往库存管理修改'),
                      child: Icon(Icons.info_outline_rounded, size: 20),
                    )
                  : null,
              hintText: widget.readOnly ? '库存禁用' : '请输入库存',
              keyboardType: const TextInputType.numberWithOptions(
                signed: false,
                decimal: false,
              ),
              formatters: [NumberInputFormatter(decimal: 0)],
              onChanged: (value) {
                item.stock = int.tryParse(value);
                widget.onChanged?.call(_skus);
              },
            );
          }),
        ),
      ],
    );
  }
}

class _SKUSelect extends StatefulWidget {
  final List<CommoditySpecModel> colors;
  final List<CommoditySpecModel> sizes;
  final List<CommoditySpecModel> colorValues;
  final List<CommoditySpecModel> sizeValues;
  final ValueChanged<List<CommoditySpecModel>>? onColorsChanged;
  final ValueChanged<List<CommoditySpecModel>>? onSizesChanged;

  const _SKUSelect({
    Key? key,
    required this.colors,
    required this.sizes,
    this.colorValues = const [],
    this.sizeValues = const [],
    this.onColorsChanged,
    this.onSizesChanged,
  }) : super(key: key);

  @override
  State<_SKUSelect> createState() => _SKUSelectState();
}

class _SKUSelectState extends State<_SKUSelect> {
  List<CommoditySpecModel> _colorValues = [];
  List<CommoditySpecModel> _sizeValues = [];

  @override
  void initState() {
    _colorValues = [...widget.colorValues];
    _sizeValues = [...widget.sizeValues];
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _SKUSelect oldWidget) {
    _colorValues = [...widget.colorValues];
    _sizeValues = [...widget.sizeValues];
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: SingleChildScrollView(
        child: DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('颜色'),
              const SizedBox(height: 10),
              CustomCheckboxGroup<CommoditySpecModel>(
                rowCount: 4,
                items: widget.colors,
                values: _colorValues,
                builder: (index, item, isSelected) {
                  return CustomChoose(
                    value: isSelected,
                    child: Text(item.name ?? '-'),
                  );
                },
                onChanged: (values) {
                  if (values.isEmpty) {
                    _colorValues = [widget.colors.first];
                  } else if (values.last.id == widget.colors.first.id) {
                    _colorValues = [widget.colors.first];
                  } else if (_colorValues.isNotEmpty) {
                    _colorValues = values;
                    _colorValues.remove(widget.colors.first);
                  } else {
                    _colorValues = values;
                  }
                  setState(() {});
                  widget.onColorsChanged?.call(_colorValues);
                },
              ),
              const SizedBox(height: 20),
              const Text('尺码'),
              const SizedBox(height: 10),
              CustomCheckboxGroup<CommoditySpecModel>(
                rowCount: 4,
                items: widget.sizes,
                values: _sizeValues,
                builder: (index, item, isSelected) {
                  return CustomChoose(
                    value: isSelected,
                    child: Text(item.name ?? '-'),
                  );
                },
                onChanged: (values) {
                  if (values.isEmpty) {
                    _sizeValues = [widget.sizes.first];
                  } else if (values.last.id == widget.sizes.first.id) {
                    _sizeValues = [widget.sizes.first];
                  } else if (_sizeValues.isNotEmpty) {
                    _sizeValues = values;
                    _sizeValues.remove(widget.sizes.first);
                  } else {
                    _sizeValues = values;
                  }
                  setState(() {});
                  widget.onSizesChanged?.call(_sizeValues);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
