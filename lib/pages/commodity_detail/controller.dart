part of pages.commodity_detail;

class CommodityDetailController extends GetxController {
  final String? id;
  final TextEditingController inputName = TextEditingController();
  final TextEditingController inputCode = TextEditingController();

  final TextEditingController inputEntryPrice = TextEditingController();
  final TextEditingController inputPrice = TextEditingController();
  final TextEditingController inputDiscount = TextEditingController();
  final TextEditingController inputBarcode = TextEditingController();

  ValueKey<int>? clearKey;
  List<CommoditySpecModel> colorValues = [];
  List<CommoditySpecModel> sizeValues = [];
  CommodityModel detail = CommodityModel();
  List<CommodityAttrModel> seasonList = [];
  CommodityAttrModel? season;
  bool isSales = true;

  List<CommoditySKUModel> _skus = [];
  String? _cover;
  bool _isCoverUploading = false;

  CommodityDetailController([this.id]);

  bool get isEdit => (id ?? '').isNotEmpty;

  @override
  void onInit() {
    if (!isEdit) {
      inputBarcode.text = Tools.generateBarcode();
      inputCode.text = Tools.generateBarcode(false);
    }
    super.onInit();
  }

  @override
  void onReady() {
    _getSeasonList();
    if (isEdit) _getDetail();
    super.onReady();
  }

  @override
  void onClose() {
    inputName.dispose();
    inputCode.dispose();
    inputEntryPrice.dispose();
    inputPrice.dispose();
    inputDiscount.dispose();
    inputBarcode.dispose();
    super.onClose();
  }

  void _getDetail() async {
    detail = await CommodityAPI.detail(id!);
    inputName.text = detail.name ?? '';
    inputCode.text = detail.code ?? '';
    inputEntryPrice.text = Tools.toAmount(detail.entryPrice);
    inputPrice.text = Tools.toAmount(detail.price);
    inputDiscount.text = ((detail.discount ?? 0) / 100).toStringAsFixed(0);
    inputBarcode.text = detail.barcode ?? '';
    isSales = detail.isSales ?? true;
    colorValues = detail.colors ?? [];
    sizeValues = detail.sizes ?? [];
    season = detail.season;
    update();
  }

  void _getSeasonList() async {
    seasonList = await CommodityAPI.attributeList('1');
    update(['season_list']);
  }

  void uploadCoverBefore(File? value) {
    _isCoverUploading = true;
  }

  void uploadCoverAfter(String? value) {
    _cover = value;
    _isCoverUploading = false;
  }

  void changeSKUs(List<CommoditySKUModel> value) => _skus = value;

  void changeColors(List<CommoditySpecModel> value) => colorValues = value;

  void changeSizes(List<CommoditySpecModel> value) => sizeValues = value;

  void changeSeason(CommodityAttrModel? value) => season = value;

  void changeSales(bool value) => isSales = value;

  void changeBarcode() => inputBarcode.text = Tools.generateBarcode();

  Future<void> submit(BuildContext context) async {
    final name = inputName.value.text.trim();
    final barcode = inputBarcode.value.text;
    final price = inputPrice.value.text;
    if (_isCoverUploading) {
      CustomToast.text('图片正在上传，请稍后');
      return;
    }
    if (name.isEmpty) {
      CustomToast.text('请输入名称');
      return;
    }
    if (!isEdit && _skus.any((element) => (element.stock ?? 0) <= 0)) {
      CustomToast.text('请输入库存');
      return;
    }
    if (price.isEmpty) {
      CustomToast.text('请输入零售价');
      return;
    }
    if (barcode.isEmpty) {
      CustomToast.text('请生成条码');
      return;
    }
    for (var element in _skus) {
      if ((element.barcode ?? '').isEmpty) {
        element.barcode = Tools.generateBarcode();
      }
    }
    await CommodityAPI.add(
      id: id,
      name: name,
      cover: _cover ?? detail.cover,
      isSales: isSales,
      code: inputCode.value.text,
      barcode: barcode,
      price: double.tryParse(price) ?? 0,
      entryPrice: double.tryParse(inputEntryPrice.value.text),
      discount: int.tryParse(inputDiscount.value.text),
      sku: _skus,
      season: season,
    );

    if (!isEdit) {
      // _changePrintData();

      inputName.text = '';
      inputCode.text = Tools.generateBarcode(false);
      inputEntryPrice.text = '';
      inputPrice.text = '';
      inputDiscount.text = '';
      inputBarcode.text = Tools.generateBarcode();
      season = null;
      _skus = [];
      colorValues = [];
      sizeValues = [];
      clearKey = ValueKey(DateTime.now().millisecondsSinceEpoch);
      update();

      CustomToast.success('新增成功');
      return;
    }
    if (context.mounted) context.pop();
  }
}
