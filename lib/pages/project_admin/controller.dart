/// @Description:
/// @Author: 歪脖子
/// @Date: 2023-10-29 14:14

part of pages.project_admin;

class ProjectAdminController extends GetxController {
  final EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  List<ProjectBuildModel> dataList = [];

  final int _limit = 20;
  int _page = 1;
  bool _noMore = false;
  List<EnumModel> statusList = [];
  EnumModel? status; //选中的施工
  // int? selectedStatus; //选中的施工状态

  List<EnumModel> placeList = [];
  EnumModel? place; //选中的施工

  List<EnumModel> constractList = [];
  EnumModel? constract; //选中的施工

  List<EnumModel> cutList = [];
  EnumModel? cut; //选中的施工

  List<EnumModel> pstatusList = [];
  EnumModel? pstatus; //选中的施工

  List<EnumModel> stateBackList = [];
  EnumModel? stateBack; //退回状态

  List<EnumModel> bstateList = [];
  EnumModel? bstate; //停水状态

  final TextEditingController searchProjectName =
      TextEditingController(); //工程名称
  final TextEditingController searchProjectNum = TextEditingController(); //内部编号
  final TextEditingController searchProjectOutNum =
      TextEditingController(); //内部编号

  ///////////////////////////////////////////////////////////////////////////
  void changeStatus(EnumModel? value) {
    int? statusId = value?.id;
    // selectedStatus = value?.id;

    for (EnumModel seas in statusList) {
      if (seas.id == statusId) {
        status = seas;
      }
    }
    update();
  }

  void changePlace(EnumModel? value) {
    int? statusId = value?.id;

    for (EnumModel seas in placeList) {
      if (seas.id == statusId) {
        place = seas;
      }
    }
    update();
  }

  void changeConstract(EnumModel? value) {
    int? statusId = value?.id;

    for (EnumModel seas in constractList) {
      if (seas.id == statusId) {
        constract = seas;
      }
    }
    update();
  }

  void changePStatus(EnumModel? value) {
    int? statusId = value?.id;

    for (EnumModel seas in pstatusList) {
      if (seas.id == statusId) {
        pstatus = seas;
      }
    }
    update();
  }

  void changeStateBack(EnumModel? value) {
    int? statusId = value?.id;

    for (EnumModel seas in stateBackList) {
      if (seas.id == statusId) {
        stateBack = seas;
      }
    }
    update();
  }

  void changeBState(EnumModel? value) {
    int? statusId = value?.id;

    for (EnumModel seas in bstateList) {
      if (seas.id == statusId) {
        bstate = seas;
      }
    }
    update();
  }

  @override
  void onReady() {
    // 所属工程列表
    _geEnumList();

    super.onReady();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  void _geEnumList() async {
    // 项目状态列表
    statusList = await EnumAPI.list(
      Parent: 106,
      EnumType: 18,
    );
    placeList = await EnumAPI.list(
      Parent: 77,
      EnumType: 16,
    );
    constractList = await EnumAPI.list(
      Parent: 5,
      EnumType: 4,
    );
    pstatusList.addAll([
      EnumModel.fromJson({'name': '已配置', 'id': 1}),
      EnumModel.fromJson(
        {'name': '已施工', 'id': 2},
      ),
      EnumModel.fromJson(
        {'name': '已完工', 'id': 4},
      ),
      EnumModel.fromJson(
        {'name': '已审计', 'id': 5},
      ),
      EnumModel.fromJson(
        {'name': '已归档', 'id': 6},
      ),
      EnumModel.fromJson(
        {'name': '待支付', 'id': 7},
      ),
    ]);
    stateBackList.addAll([
      EnumModel.fromJson(
        {'name': '正常', 'id': 0},
      ),
      EnumModel.fromJson(
        {'name': '退回', 'id': 1},
      ),
    ]);
  }

  void search() async {
    _getDataList(true);
  }

  void reset() async {
    bstate = null;
    status = null;
    place = null;
    constract = null;
    pstatus = null;
    stateBack = null;

    searchProjectOutNum.text = '';
    searchProjectNum.text = '';
    searchProjectName.text = '';
    _getDataList(true);
  }

  Future<void> _getDataList([bool isRefresh = false]) async {
    // print('isRefresh,$isRefresh,$selectedStatus');

    if (isRefresh) _page = 1;
    final result = await ProjectBuildAPI.list(
      merchantID: ShopStore.to.info.id ?? '',
      BStatus: status?.id, //施工状态
      BState: bstate?.id, //停水状态
      PlaceID: place?.id,
      ConstractType: constract?.id,
      Status: pstatus?.id,
      State: stateBack?.id,
      NumberLike: searchProjectNum.text.trim(),
      OutNumberLike: searchProjectOutNum.text.trim(),
      NameLike: searchProjectName.text.trim(),
      page: _page,
      limit: _limit,
    );

    if (isRefresh) dataList.clear();
    dataList.addAll(result);

    _page++;
    _noMore = result.length < _limit;
    update();
  }

  void onRefresh() async {
    try {
      await _getDataList(true);
      refreshController.finishRefresh(IndicatorResult.success);
      refreshController.resetFooter();
    } catch (error) {
      refreshController.finishRefresh(IndicatorResult.fail);
    }
  }

  void onLoading() async {
    if (_noMore) {
      refreshController.finishLoad(IndicatorResult.noMore);
      return;
    }
    try {
      await _getDataList();
      refreshController.finishLoad();
    } catch (error) {
      refreshController.finishLoad(IndicatorResult.fail);
    }
  }
}
