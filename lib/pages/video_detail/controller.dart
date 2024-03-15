part of pages.video_detail;

class CommodityDetailController extends GetxController {
  final String? id;

  final TextEditingController selectProjectName =
      TextEditingController(); //所在工程
  final TextEditingController deviceName = TextEditingController();
  final TextEditingController deviceID = TextEditingController();
  final TextEditingController deviceUser = TextEditingController();
  final TextEditingController userPhone = TextEditingController();
  // TextEditingController projectID = TextEditingController(); //所在工程

  final TextEditingController inputEntryPrice = TextEditingController();
  final TextEditingController inputPrice = TextEditingController();
  final TextEditingController inputDiscount = TextEditingController();
  final TextEditingController inputBarcode = TextEditingController();

  ValueKey<int>? clearKey;
  List<CommoditySpecModel> colorValues = [];
  List<CommoditySpecModel> sizeValues = [];
  VideoModel detail = VideoModel();
  List<ProjectModel> seasonList = [];
  List<String> prjNameList = [];

  ProjectModel? season;
  int? activePrjIndex;
  bool isSales = true;

  List<CommoditySKUModel> _skus = [];
  String? _cover;
  String? editDate; //修改时间
  int? projectID; //所在工程id
  bool _isCoverUploading = false;

  CommodityDetailController([this.id]);

  bool get isEdit => (id ?? '').isNotEmpty;

  @override
  void onInit() {
    // if (!isEdit) {
    // inputBarcode.text = Tools.generateBarcode();
    // inputCode.text = Tools.generateBarcode(false);
    // }
    super.onInit();
  }

  @override
  void onReady() {
    // 所属工程列表
    _getProList();
    print('isEdit,$isEdit');

    //if (isEdit) _getDetail();
    super.onReady();
  }

  @override
  void onClose() {
    deviceName.dispose();
    deviceID.dispose();
    deviceUser.dispose();
    userPhone.dispose();

    inputEntryPrice.dispose();
    inputPrice.dispose();
    inputDiscount.dispose();
    inputBarcode.dispose();
    super.onClose();
  }

  void _getDetail() async {
    detail = await VideoAPI.detail(id!);
    deviceID.text = detail.deviceID ?? '';
    deviceName.text = detail.deviceName ?? '';
    deviceUser.text = detail.deviceUser ?? '';
    userPhone.text = detail.userPhone ?? '';

    //  season = detail.projectID;

    projectID = detail.projectID;

    editDate = detail.editDate;

    for (ProjectModel seas in seasonList) {
      if (seas.id == projectID) {
        // season = seas;
        activePrjIndex = seasonList.indexOf(seas);
        selectProjectName.text = detail.projectName ?? '';
        print('activePrjIndex,$activePrjIndex');
      }
      prjNameList.add(seas.name ?? '');
    }
    print('season,$season');
    update();
  }

  void _getProList() async {
    int limit = 0;
    int page = 1;
    seasonList = await ProjectAPI.list(
      merchantID: ShopStore.to.info.id ?? '',
      page: page,
      limit: limit,
    );
    print('seasonList,$seasonList');

    update(['season_list']);

    if (isEdit) _getDetail();
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

  // void changeSeason(ProjectModel? value) {
  //   selectProjectName.text = value?.name ?? '';
  //   projectID = value?.id;
  // }

  void changeSales(bool value) => isSales = value;

  void changeBarcode() => inputBarcode.text = Tools.generateBarcode();

  Future<void> submit(BuildContext context) async {
    final deviceName2 = deviceName.value.text.trim();

    final deviceId = deviceID.value.text.trim();
    final deviceUser2 = deviceUser.value.text.trim();
    final devicePhone = userPhone.value.text.trim();
    print('device_id,$deviceId');

    // final barcode = inputBarcode.value.text;
    // final price = inputPrice.value.text;
    // if (_isCoverUploading) {
    //   CustomToast.text('图片正在上传，请稍后');
    //   return;
    // }
    if (deviceName2.isEmpty) {
      CustomToast.text('请输入名称');
      return;
    }
    if (deviceId.isEmpty) {
      CustomToast.text('请输入id');
      return;
    }
    await VideoAPI.add(
      id: id,
      deviceID: deviceId,
      deviceName: deviceName2,
      deviceUser: deviceUser2,
      userPhone: devicePhone,
      projectID: projectID,
      editDate: editDate,
    );
    // if (!isEdit && _skus.any((element) => (element.stock ?? 0) <= 0)) {
    //   CustomToast.text('请输入库存');
    //   return;
    // }

// 清理工作
    if (!isEdit) {
      deviceName.text = '';
      deviceID.text = '';
      deviceUser.text = '';
      userPhone.text = '';

      projectID = null;

      season = null;
      editDate = '';
      clearKey = ValueKey(DateTime.now().millisecondsSinceEpoch);
      update();

      CustomToast.success('新增成功');
      // return;
    } else {
      clearKey = ValueKey(DateTime.now().millisecondsSinceEpoch);
      update();
      CustomToast.success('编辑成功');
    }
    print(context.mounted);

    if (context.mounted) Navigator.of(context).pop(true);
    // if (context.mounted) context.pop(tr);
  }
}
