part of pages.commodity;

class BuildGoods extends StatefulWidget {
  final String? cover;
  final String? name;
  final String? code;
  final int? stock;
  final int? price;
  final bool isSales;
  final void Function()? onTap;
  final void Function()? onStock;
  final void Function()? onRemove;
  final Future<void> Function()? onShelves;

  const BuildGoods({
    super.key,
    this.onTap,
    this.onShelves,
    this.cover,
    this.name,
    this.code,
    this.stock,
    this.price,
    this.isSales = false,
    this.onRemove,
    this.onStock,
  });

  @override
  State<BuildGoods> createState() => _BuildGoodsState();
}

class _BuildGoodsState extends State<BuildGoods> {
  final GlobalKey _anchorKey = GlobalKey();

  Color? get _stockColor {
    if ((widget.stock ?? 0) < 1) return AppTheme.error;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomPopup(
      anchorKey: _anchorKey,
      isLongPress: true,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(
            padding: EdgeInsets.zero,
            width: 85,
            height: 34,
            size: CustomButtonSize.small,
            foregroundColor: AppTheme.info,
            onPressed: () {
              Navigator.of(context).pop();
              widget.onStock?.call();
            },
            child: const Text('库存管理'),
          ),
          const SizedBox(width: 10),
          CustomButton(
            padding: EdgeInsets.zero,
            width: 85,
            height: 34,
            size: CustomButtonSize.small,
            foregroundColor: AppTheme.error,
            onPressed: () {
              Navigator.of(context).pop();
              widget.onRemove?.call();
            },
            child: const Text('删除'),
          ),
        ],
      ),
      child: CustomCard(
        padding: const EdgeInsets.all(10),
        onTap: widget.onTap,
        child: Row(
          children: [
            CustomImage.network(
              key: _anchorKey,
              url: widget.cover ?? '',
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(widget.code ?? ''),
                      ),
                      Text(
                        Tools.toAmount(widget.price),
                        style: const TextStyle(
                          fontFamily: 'number',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  DefaultTextStyle.merge(
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSecondary,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.name ?? 'Unnamed',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        Text(
                          '库存：${widget.stock ?? 0}',
                          style: TextStyle(color: _stockColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            _SalesButton(
              isSales: widget.isSales,
              onShelves: widget.onShelves,
            ),
          ],
        ),
      ),
    );
  }
}

class _SalesButton extends StatefulWidget {
  final bool isSales;
  final Future<void> Function()? onShelves;

  const _SalesButton({
    Key? key,
    this.isSales = false,
    this.onShelves,
  }) : super(key: key);

  @override
  State<_SalesButton> createState() => _SalesButtonState();
}

class _SalesButtonState extends State<_SalesButton> {
  bool _isSubmitting = false;
  bool _isSales = false;

  @override
  void initState() {
    _isSales = widget.isSales;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _SalesButton oldWidget) {
    _isSales = widget.isSales;
    super.didUpdateWidget(oldWidget);
  }

  void _changeStatus() async {
    if (_isSubmitting) return;
    if (mounted) {
      setState(() {
        _isSubmitting = true;
      });
    }

    try {
      await widget.onShelves?.call();
      _isSales = !_isSales;
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomButton(
      width: 45,
      height: 30,
      padding: EdgeInsets.zero,
      fontSize: 12,
      foregroundColor: _isSales ? colorScheme.onTertiary : null,
      onPressed: _changeStatus,
      child: _isSubmitting
          ? CustomLoadingIndicator(
              strokeWidth: 2,
              color: _isSales ? colorScheme.onTertiary : null,
              padding: const EdgeInsets.all(7),
            )
          : Text(_isSales ? '下架' : '上架'),
    );
  }
}
