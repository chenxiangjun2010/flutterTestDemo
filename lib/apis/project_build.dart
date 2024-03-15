part of apis;

abstract class ProjectBuildAPI {
  /// 工程列表
  static Future<List<ProjectBuildModel>> list({
    required String merchantID,
    int page = 1,
    int limit = 20,
    int? BStatus,
    int? BState,
    int? PlaceID,
    int? ConstractType,
    int? Status,
    int? State,
    String? NameLike,
    String? OutNumberLike,
    String? NumberLike,
  }) async {
    final result = await HttpService.to.get(
      '/api/ProjectBuild/List',
      params: {
        'index': page,
        'size': limit,
        'BStatus': BStatus,
        'BState': BState,
        'PlaceID': PlaceID,
        'ConstractType': ConstractType,
        'Status': Status,
        'State': State,
        'NameLike': NameLike,
        'NumberLike': NumberLike,
        'OutNumberLike': OutNumberLike,
      },
    );

    return List.generate(result.data.length, (index) {
      return ProjectBuildModel.fromJson(result.data[index]);
    });
  }

  // 详情
  static Future<ProjectBuildDetailModel> detail(String id) async {
    final result = await HttpService.to.get(
      '/api/ProjectBuild/Info',
      showLoading: true,
      params: {'id': id},
    );

    if (result.data is! Map) return ProjectBuildDetailModel();
    return ProjectBuildDetailModel.fromJson(result.data);
  }

  /// 添加 编辑
  static Future<void> add({
    List<String?>? advanceIDs,
    List<String?>? payLists,
    List<String?>? advanceLists,
    List<String?>? progressIDs,
    List<String?>? inComeLists,
    List<String?>? listIDs,
    String? id = '',
    List<String?>? constructFiles,
    List<String?>? endPicFiles,
    List<String?>? pipeFiles,
    List<String?>? cutFiles,
    List<String?>? discloseFiles,
    List<String?>? endFiles,
    List<String?>? percentFiles,
    List<String?>? visaLists,
    List<String?>? startFiles,
    List<String?>? planFiles,
    String dep = '',
    int? projectID,
    String? duration,
    String? percent,
    String? lat,
    String? lng,
    int? status,
    String? editDate,
    String? cutEndDate,
    String? cutStartDate,
    String? discloseDate,
    String? endDate,
    String? pipelineDate,
    String? startDate,
    String? userPhone,
    List<String?>? fileIDs,
  }) async {
    final isEdit = (id ?? '').isNotEmpty;
    // final attrs = <Map>[];
    // if (season != null) {
    //   attrs.add({
    //     'attrId': season.id,
    //     'attrName': season.name,
    //     'attrType': '1',
    //     'check': false,
    //   });
    // }
    if (!isEdit) {
      editDate = '1900-01-01 00:00:00.000';
    }
    final params = <String, dynamic>{
      'advanceIDs': advanceIDs,
      'payLists': payLists,
      'advanceLists': advanceLists,
      'progressIDs': progressIDs,
      'inComeLists': inComeLists,
      'listIDs': listIDs,
      'fileIDs': fileIDs,
      'id': id ?? '0',
      'constructFiles': constructFiles,
      'endPicFiles': endPicFiles,
      'pipeFiles': pipeFiles,
      'cutFiles': cutFiles,
      'discloseFiles': discloseFiles,
      'endFiles': endFiles,
      'percentFiles': percentFiles,
      'visaLists': visaLists,
      'startFiles': startFiles,
      'planFiles': planFiles,
      'dep': dep,
      'projectID': projectID,
      'duration': duration,
      'percent': percent,
      'lat': lat,
      'lng': lng,
      'status': status,
      'editDate': editDate,
      'cutEndDate': cutEndDate,
      'cutStartDate': cutStartDate,
      'discloseDate': discloseDate,
      'pipelineDate': pipelineDate,
      'endDate': endDate,
      'startDate': startDate,
    };
    print('params,$params');

    await HttpService.to.post(
      isEdit ? '/api/ProjectBuild/Edit' : '/api/ProjectBuild/Add',
      showLoading: true,
      params: params,
    );
  }

  // 详情
  static Future<VisaList> detailVisa(String id) async {
    print('id2222222$id');

    final result = await HttpService.to.get(
      '/api/VisaInfo/Info',
      showLoading: true,
      params: {'id': int.tryParse(id)},
    );
    print('result,$result');

    if (result.data is! Map) return VisaList();
    return VisaList.fromJson(result.data);
  }

// add visa VisaInfo/Info?id=37
  static Future<FileAllCommonModel> updateVisa({
    String? id = '',
    String? editDate,
    List<String?>? files,
    String intro = '',
  }) async {
    final params = <String, dynamic>{
      'files': files,
      'intro': intro,
    };
    final isEdit = id != '0';
    if (isEdit) {
      params['id'] = id;
      params['editDate'] = editDate;
    }
    print('isEdit,$isEdit');

    final result = await HttpService.to.post(
      isEdit ? '/api/VisaInfo/Edit' : '/api/VisaInfo/AddInfo',
      showLoading: true,
      params: params,
    );
    return FileAllCommonModel.fromJson(result.data ?? {});
  }

// delete visa
  static Future<void> deleteVisa({
    required int id,
  }) async {
    final params = <String, dynamic>{
      'id': id,
    };

    await HttpService.to.post(
      '/api/VisaInfo/Delete',
      showLoading: true,
      params: params,
    );
  }
}
