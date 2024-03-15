part of pages.project_detail;

class ProjectDetailController extends GetxController {
  final String? id;
  final String? projectID; //所在工程id
  final TextEditingController deviceName = TextEditingController();
  final TextEditingController initProjectName = TextEditingController(); //工程名称
  final TextEditingController initProjectNum = TextEditingController(); //内部编号
  final TextEditingController initStatusName = TextEditingController(); //状态
  final TextEditingController initUnitName = TextEditingController(); //建设单位
  final TextEditingController initPlaceName = TextEditingController(); //工程属地
  final TextEditingController initCreateTime = TextEditingController(); //建档日期
  final TextEditingController initBudget = TextEditingController(); //金额
  final TextEditingController initSignDate = TextEditingController(); //合同签订日期
  final TextEditingController initConstructTypeName =
      TextEditingController(); //项目类别
  final TextEditingController initProjectOutNum =
      TextEditingController(); //外部编号
  final TextEditingController selectDiscloseDate =
      TextEditingController(); //交底日期
  final TextEditingController selectPipeDiscloseDate =
      TextEditingController(); //管线交底日期
  final TextEditingController selectCutStartDateTime =
      TextEditingController(); //停水开始时间
  final TextEditingController selectCutEndDateTime =
      TextEditingController(); //停水结束时间
  final TextEditingController selectStartDate = TextEditingController(); //开工工期
  final TextEditingController selectEndDate = TextEditingController(); //完工工期
  final TextEditingController inputDuration = TextEditingController(); //计划工期
  final TextEditingController inputPercent = TextEditingController(); //完成百分比
  final TextEditingController inputDep = TextEditingController(); //备注
  final TextEditingController latAndLng = TextEditingController(); //经纬度

  List<CommonFile> selectEndPicFiles = []; //完工图片
  List<CommonFile> selectConstructFiles = []; //文明施工图片
  List<CommonFile> selectPipeFiles = []; //管线现场图片
  List<CommonFile> selectDiscloseFiles = []; //交底记录
  List<CommonFile> selectPlanFiles = []; //施工组织计划
  List<CommonFile> selectStartFiles = []; //开工报告
  List<CommonFile> selectPercentFiles = []; //工作量完成报告
  List<CommonFile> selectCutFiles = []; //停水报告
  List<CommonFile> selectEndFiles = []; //完工报告
  List<VisaList> selectVisaFiles = []; //selectVisaFiles

  List<CommonFile> toEndPicFiles = []; //完工图片- 新增
  List<CommonFile> toConstructFiles = []; //文明施工图片 新增
  List<CommonFile> toPipeFiles = []; //管线现场图片 新增
  List<CommonFile> toDiscloseFiles = []; //交底记录 新增
  List<CommonFile> toPlanFiles = []; //施工组织计划 新增
  List<CommonFile> toStartFiles = []; //开工报告 新增
  List<CommonFile> toPercentFiles = []; //工作量完成报告 新增
  List<CommonFile> toCutFiles = []; //停水报告 新增
  List<CommonFile> toEndFiles = []; //完工报告 新增
  List<CommonFile> toVisaFiles = []; //完工报告 新增

  List<String> toDeleteFileIds = [];

  final TextEditingController inputEntryPrice = TextEditingController();
  final TextEditingController inputPrice = TextEditingController();
  final TextEditingController inputDiscount = TextEditingController();
  final TextEditingController inputBarcode = TextEditingController();

  ValueKey<int>? clearKey1;
  ValueKey<int>? clearKey2;
  ValueKey<int>? clearKey3;
  List<CommoditySpecModel> colorValues = [];
  List<CommoditySpecModel> sizeValues = [];
  ProjectBuildDetailModel detail = ProjectBuildDetailModel();
  ProjectBaseModel initDetail = ProjectBaseModel();
  List<EnumModel> statusList = [];
  EnumModel? state;
  bool isSales = true;

  List<CommoditySKUModel> _skus = [];
  String? _cover;
  String? editDate; //修改时间
  String? discloseDate; //交底日期
  int? selectedStatus; //选中的施工状态
  List<int> statesSels = [];
  List<KeyValueModel> statesList = []; //选择列表

  final bool _isCoverUploading = false;

  ProjectDetailController(this.id, this.projectID);

  bool get isEdit => (id ?? '').isNotEmpty;

  @override
  void onInit() {
    // if (!isEdit) {
    // inputBarcode.text = Tools.generateBarcode();
    // inputCode.text = Tools.generateBarcode(false);
    // }
    super.onInit();

    // initPatformState();
  }

  @override
  void onReady() {
    // 所属工程列表
    _geEnumList();

    //if (isEdit) _getDetail();
    super.onReady();
  }

  @override
  void onClose() {
    deviceName.dispose();

    selectDiscloseDate.dispose();
    selectPipeDiscloseDate.dispose();
    selectStartDate.dispose();
    selectEndDate.dispose();
    selectCutStartDateTime.dispose();
    selectCutEndDateTime.dispose();

    inputEntryPrice.dispose();
    inputPrice.dispose();
    inputDiscount.dispose();
    inputBarcode.dispose();
    super.onClose();
  }

  String formatRawDate(value, defaul) {
    return (value ?? '').split(" ")[0] == "1900-01-01"
        ? defaul
        : (value ?? '').split(" ")[0];
  }

  String formatRawDateTime(value, defaul) {
    return (value ?? '').split(" ")[0] == "1900-01-01"
        ? defaul
        : (value ?? '').split(".")[0];
  }

  String formatToRawDate(value) {
    return value == '' ? '1900-01-01 00:00:00.000' : '$value 00:00:00.000';
  }

  String formatToRawDateTime(value) {
    return value == '' ? '1900-01-01 00:00:00.000' : '$value.000';
  }

  Future<void> updateEditDate() async {
    detail = await ProjectBuildAPI.detail(id!);
    CustomToast.success('操作成功');
  }

  void _getDetail() async {
    detail = await ProjectBuildAPI.detail(id!);
    initDetail = await ProjectAPI.detail(projectID!);

    selectedStatus = detail.bStatus;

// 顶部init数据显示
    initProjectName.text = detail.projectName ?? '';
    initProjectNum.text = detail.projectNum ?? '';
    initProjectOutNum.text = detail.projectOutNum ?? '';
    initConstructTypeName.text = initDetail.constructTypeName ?? '';
    initStatusName.text = initDetail.statusName ?? '';
    initUnitName.text = initDetail.unitName ?? '';
    initPlaceName.text = initDetail.placeName ?? '';
    initBudget.text = initDetail.budget.toString();
    initCreateTime.text = formatRawDate(initDetail.createTime, '-');

    initSignDate.text = formatRawDate(initDetail.signDate, '-');

    editDate = detail.editDate;
    // 图片
    selectEndPicFiles.addAll(detail.endPicFiles ?? []);
    selectConstructFiles.addAll(detail.constructFiles ?? []);
    selectPipeFiles.addAll(detail.pipeFiles ?? []);
    // 文件
    selectDiscloseFiles.addAll(detail.discloseFiles ?? []);
    selectStartFiles.addAll(detail.startFiles ?? []);
    selectPlanFiles.addAll(detail.planFiles ?? []);
    selectPercentFiles.addAll(detail.percentFiles ?? []);
    selectCutFiles.addAll(detail.cutFiles ?? []);
    selectEndFiles.addAll(detail.endFiles ?? []);
    selectVisaFiles.addAll(detail.visaLists ?? []);

// 日期
    selectDiscloseDate.text = formatRawDate(detail.discloseDate, '');
    selectPipeDiscloseDate.text = formatRawDate(detail.pipelineDate, '');
    selectPipeDiscloseDate.text = formatRawDate(detail.pipelineDate, '');
    selectCutStartDateTime.text = formatRawDateTime(detail.cutStartDate, '');
    selectCutEndDateTime.text = formatRawDateTime(detail.cutEndDate, '');
    selectStartDate.text = formatRawDate(detail.startDate, '');
    selectEndDate.text = formatRawDate(detail.endDate, '');
    inputDuration.text = detail.duration.toString();
    inputPercent.text = detail.percent.toString();

    inputDep.text = detail.dep ?? '';
    latAndLng.text = '${detail.lat},${detail.lng}';

// state = detail.bStatus;
    for (EnumModel seas in statusList) {
      if (seas.id == detail.bStatus) {
        state = seas;
      }
    }

    print('season,$state');
    update();
  }

  void uploadCoverBefore(File? value) {
    // _isCoverUploading = true;
  }

// add
  void uploadCoverAfterEndPic(FileAllCommonModel? value) {
    if (value == null) {
      return;
    }
    toEndPicFiles.add(CommonFile.fromJson({
      'filePath': value.filePath,
      'id': 0,
      'bh': value.bh,
    }));
    update();
    // _isCoverUploading = false;
  }

///////////////////////////////////////////////////////////////////////////
  void uploadCoverAfterConstruct(FileAllCommonModel? value) {
    if (value == null) {
      return;
    }
    toConstructFiles.add(CommonFile.fromJson({
      'filePath': value.filePath,
      'id': 0,
      'bh': value.bh,
    }));
    update();
    // _isCoverUploading = false;
  }

// 管线交底记录文件添加完毕
  void uploadCoverAfterPipe(FileAllCommonModel? value) {
    if (value == null) {
      return;
    }
    toPipeFiles.add(CommonFile.fromJson({
      'filePath': value.filePath,
      'id': 0,
      'bh': value.bh,
    }));
    update();
    // _isCoverUploading = false;
  }

// 交底记录文件添加完毕
  void uploadAfterDiscloseFile(FileAllCommonModel? value) {
    if (value == null) {
      return;
    }
    toDiscloseFiles.add(CommonFile.fromJson({
      'filePath': value.filePath,
      'id': 0,
      'bh': value.bh,
    }));

    update();
  }

// 施工组织计划文件添加完毕
  void uploadAfterPlanFile(FileAllCommonModel? value) {
    if (value == null) {
      return;
    }
    toPlanFiles.add(CommonFile.fromJson({
      'filePath': value.filePath,
      'id': 0,
      'bh': value.bh,
    }));

    update();
  }

// 开工报告文件添加完毕
  void uploadAfterStartFile(FileAllCommonModel? value) {
    if (value == null) {
      return;
    }
    toStartFiles.add(CommonFile.fromJson({
      'filePath': value.filePath,
      'id': 0,
      'bh': value.bh,
    }));

    update();
  }

// 工作量完成文件添加完毕
  void uploadAfterPercentFile(FileAllCommonModel? value) {
    if (value == null) {
      return;
    }
    toPercentFiles.add(CommonFile.fromJson({
      'filePath': value.filePath,
      'id': 0,
      'bh': value.bh,
    }));

    update();
  }

// 停水报告文件添加完毕
  void uploadAfterCutFile(FileAllCommonModel? value) {
    if (value == null) {
      return;
    }
    toCutFiles.add(CommonFile.fromJson({
      'filePath': value.filePath,
      'id': 0,
      'bh': value.bh,
    }));

    update();
  }

// 完工报告文件添加完毕
  void uploadAfterEndFile(FileAllCommonModel? value) {
    if (value == null) {
      return;
    }
    toEndFiles.add(CommonFile.fromJson({
      'filePath': value.filePath,
      'id': 0,
      'bh': value.bh,
    }));

    update();
  }

// toVisaFiles
  void uploadAfterVisaFile(FileAllCommonModel? value) {
    if (value == null) {
      return;
    }
    print('value,$value');

    toVisaFiles.add(CommonFile.fromJson({
      'filePath': value.filePath,
      'id': 0,
      'bh': value.bh,
    }));
    print('toVisaFiles,$toVisaFiles');

    update();
  }

// delete
  void uploadDelete(CommonFile? value) {
    if (value == null) {
      return;
    }
  }

// delete
  void uploadCoverDeleteEndPic(CommonFile? value) {
    if (value == null) {
      return;
    }
    if (value.id == 0) {
      toEndPicFiles.removeWhere((file) => file.filePath == value.filePath);
    } else {
      selectEndPicFiles.removeWhere((file) => file.filePath == value.filePath);
      toDeleteFileIds.add(value.id.toString());
    }

    update();
  }

  void uploadCoverDeleteConstruct(CommonFile? value) {
    if (value == null) {
      return;
    }

    if (value.id == 0) {
      toConstructFiles.removeWhere((file) => file.filePath == value.filePath);
    } else {
      selectConstructFiles
          .removeWhere((file) => file.filePath == value.filePath);
      toDeleteFileIds.add(value.id.toString());
    }
    update();
  }

  void uploadCoverDeletePipe(CommonFile? value) {
    if (value == null) {
      return;
    }

    if (value.id == 0) {
      toPipeFiles.removeWhere((file) => file.filePath == value.filePath);
    } else {
      selectPipeFiles.removeWhere((file) => file.filePath == value.filePath);
      toDeleteFileIds.add(value.id.toString());
    }
    update();
  }

  void _geEnumList() async {
    // 项目状态列表
    statusList = await EnumAPI.list(
      Parent: 106,
      EnumType: 18,
    );

    statesList = List.generate(statusList.length ?? 0, (index) {
      var state = statusList[index];
      return KeyValueModel<String>(
        key: state.id.toString() ?? "-",
        value: state.name ?? "-",
      );
    });

    update(['season_list']);

    if (isEdit) _getDetail();
  }

// 洲省市选择
  void onStatesPicker() async {
    print('1');
  }

  void changeSKUs(List<CommoditySKUModel> value) => _skus = value;

  void changeColors(List<CommoditySpecModel> value) => colorValues = value;

  void changeSizes(List<CommoditySpecModel> value) => sizeValues = value;

  void changeState(EnumModel? value) {
    selectedStatus = value?.id;

    for (EnumModel seas in statusList) {
      if (seas.id == selectedStatus) {
        state = seas;
      }
    }
    update();
  }

  void changeSales(bool value) => isSales = value;

  void changeBarcode() => inputBarcode.text = Tools.generateBarcode();

  Future<void> submit(BuildContext context) async {
    print('isEdit,$isEdit');

    List<String> toconstructfilesStr = [];
    for (final file in toConstructFiles) {
      toconstructfilesStr.add(file.bh ?? '');
    }
    List<String> toendpicfilesStr = [];
    for (final file in toEndPicFiles) {
      toendpicfilesStr.add(file.bh ?? '');
    }
    List<String> topipefilesStr = [];
    for (final file in toPipeFiles) {
      topipefilesStr.add(file.bh ?? '');
    }
    List<String> toDiscloseFilesStr = [];
    for (final file in toDiscloseFiles) {
      toDiscloseFilesStr.add(file.bh ?? '');
    }
    List<String> toPlanFilesStr = [];
    for (final file in toPlanFiles) {
      toPlanFilesStr.add(file.bh ?? '');
    }
    List<String> toStartFilesStr = [];
    for (final file in toStartFiles) {
      toStartFilesStr.add(file.bh ?? '');
    }
    List<String> toPercentFilesStr = [];
    for (final file in toPercentFiles) {
      toPercentFilesStr.add(file.bh ?? '');
    }
    List<String> toCutFilesStr = [];
    for (final file in toCutFiles) {
      toCutFilesStr.add(file.bh ?? '');
    }
    List<String> toEndFilesStr = [];
    for (final file in toEndFiles) {
      toEndFilesStr.add(file.bh ?? '');
    }
    List<String> toVisaFilesStr = [];
    for (final file in toVisaFiles) {
      toVisaFilesStr.add(file.bh ?? '');
    }

    await ProjectBuildAPI.add(
      advanceIDs: [],
      payLists: [],
      advanceLists: [],
      progressIDs: [],
      inComeLists: [],
      listIDs: [], //签到删除-null
      fileIDs: toDeleteFileIds,

      id: detail.id.toString(),

      constructFiles: toconstructfilesStr, //文明施工图片
      endPicFiles: toendpicfilesStr, //完工图片
      pipeFiles: topipefilesStr, //管线现场图

      cutFiles: toCutFilesStr, //停水报告
      discloseFiles: toDiscloseFilesStr, //交底记录
      endFiles: toEndFilesStr, // //完工报告
      percentFiles: toPercentFilesStr, // //工作量完成情况
      visaLists: toVisaFilesStr, // //签证信息
      startFiles: toStartFilesStr, // //开工报告
      planFiles: toPlanFilesStr, // //施工组织计划

      dep: inputDep.text.trim(), //备注
      projectID: detail.projectId,
      duration: inputDuration.text.trim(),
      percent: inputPercent.text.trim(),
      lat: detail.lat.toString(),
      lng: detail.lng.toString(),

      status: selectedStatus,

      editDate: detail.editDate,
      cutEndDate: formatToRawDateTime(selectCutEndDateTime.text),
      cutStartDate: formatToRawDateTime(selectCutStartDateTime.text),
      discloseDate: formatToRawDate(selectDiscloseDate.text),
      endDate: formatToRawDate(selectEndDate.text),
      pipelineDate: formatToRawDate(selectPipeDiscloseDate.text),
      startDate: formatToRawDate(selectStartDate.text),
    );

// 清理工作

    if (!isEdit) {
      clearKey1 = ValueKey(DateTime.now().microsecondsSinceEpoch);
      clearKey2 = ValueKey(DateTime.now().microsecondsSinceEpoch);
      clearKey3 = ValueKey(DateTime.now().microsecondsSinceEpoch);
      update();

      CustomToast.success('新增成功');
      return;
    } else {
      clearKey1 = ValueKey(DateTime.now().microsecondsSinceEpoch);
      clearKey2 = ValueKey(DateTime.now().microsecondsSinceEpoch);
      clearKey3 = ValueKey(DateTime.now().microsecondsSinceEpoch);
      print('clearKey1,$clearKey1');
      print('clearKey2,$clearKey2');
      print('clearKey3,$clearKey3');

      update();
      CustomToast.success('编辑成功');
    }
    updateEditDate();
    // if (context.mounted) Navigator.of(context).pop();
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => const VideoAdminPage(),
    // ));
    print('isEdit,$isEdit');
  }
}
