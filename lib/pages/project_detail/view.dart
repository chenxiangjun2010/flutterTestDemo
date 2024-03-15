part of pages.project_detail;

class ProjectBuildDetailPage extends StatelessWidget {
  final String? id;
  final String? projectID;

  ProjectBuildDetailPage({super.key, this.id, this.projectID});

  final DateTime _dateTime = DateTime.now();
  @override
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GetBuilder<ProjectDetailController>(
      tag: id,
      init: ProjectDetailController(id, projectID),
      builder: (controller) => GestureDetector(
        onTap: () => Tools.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: AppTheme.primaryNavBarText),
            backgroundColor: const Color.fromRGBO(49, 85, 250, 1),
            title: Text(
              controller.isEdit ? '编辑工程施工' : '新增工程施工',
              style: const TextStyle(color: AppTheme.primaryNavBarText),
            ),
            actions: [
              CustomButton(
                type: CustomButtonType.borderless,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.margin,
                ),
                onPressed: () async {
                  Tools.unfocus();
                  await controller.submit(context);
                },
                child: const Text(
                  '提交',
                  style: TextStyle(color: AppTheme.primaryNavBarText),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              minimum: const EdgeInsets.all(AppTheme.margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 顶部信息
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(10)
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CustomCell.input(
                          title: const Text('工程名称'),
                          hintText: '',
                          controller: controller.initProjectName,
                          readOnly: true,
                        ),
                        CustomCell.input(
                          title: const Text('内部编号'),
                          hintText: '',
                          controller: controller.initProjectNum,
                          readOnly: true,
                        ),
                        CustomCell.input(
                          title: const Text('外部编号'),
                          hintText: '',
                          controller: controller.initProjectOutNum,
                          readOnly: true,
                        ),
                        CustomCell.input(
                          title: const Text('项目类别'),
                          hintText: '',
                          controller: controller.initConstructTypeName,
                          readOnly: true,
                        ),
                        CustomCell.input(
                          title: const Text('状态'),
                          hintText: '',
                          controller: controller.initStatusName,
                          readOnly: true,
                        ),
                        CustomCell.input(
                          title: const Text('建设单位'),
                          hintText: '',
                          controller: controller.initPlaceName,
                          readOnly: true,
                        ),
                        CustomCell.input(
                          title: const Text('建档日期'),
                          hintText: '',
                          controller: controller.initCreateTime,
                          readOnly: true,
                        ),
                        CustomCell.input(
                          title: const Text('金额'),
                          hintText: '',
                          controller: controller.initBudget,
                          readOnly: true,
                        ),
                        CustomCell.input(
                          title: const Text('合同签订日期'),
                          hintText: '',
                          controller: controller.initSignDate,
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  // 施工状态列表
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: Text(
                            '施工状态',
                            style: TextStyle(color: colorScheme.onSurface),
                          ),
                        ),
                        Expanded(
                          child: GetBuilder<ProjectDetailController>(
                            tag: id,
                            id: 'season_list',
                            builder: (controller) {
                              return CustomRadioGroup<EnumModel>(
                                items: controller.statusList,
                                value: controller.state,
                                rowCount: 2,
                                builder: (index, item, isSelected) {
                                  return CustomChoose(
                                    value: isSelected,
                                    child: Text(item.name ?? '-'),
                                  );
                                },
                                onChanged: controller.changeState,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 准备施工
                  const SizedBox(height: 10),
                  if (controller.selectedStatus == null ||
                      controller.selectedStatus == 107)
                    CustomCellGroup(
                      isInset: false,
                      children: [
                        // const Text('toDeleteFileIds'),
                        // for (final asset in controller.toDeleteFileIds)
                        //   Text(asset),

                        // const Text('toEndPicFiles'),
                        // for (final asset in controller.toEndPicFiles)
                        //   Text(asset.bh ?? ''),
                        // const Text('toConstructFiles'),
                        // for (final asset in controller.toConstructFiles)
                        //   Text(asset.bh ?? ''),
                        // const Text('toPipeFiles'),
                        // for (final asset in controller.toPipeFiles)
                        //   Text(asset.bh ?? ''),

                        CustomCell.input(
                          title: const Text('交底日期'),
                          hintText: '请选择交底日期',
                          readOnly: true,
                          onTap: () {
                            JhPickerTool.showDatePicker(context,
                                dateType: PickerDateType.YMD,
                                clickCallBack: (selectValue, selectIndexArr) {
                              print(selectValue);
                              print(selectIndexArr);
                              controller.selectDiscloseDate.text =
                                  selectValue.split(' ')[0];
                            });
                          },
                          controller: controller.selectDiscloseDate,
                        ),

                        CustomCell.input(
                          title: const Text('管线交底日期'),
                          hintText: '请选择管线交底日期',
                          readOnly: true,
                          onTap: () {
                            JhPickerTool.showDatePicker(context,
                                dateType: PickerDateType.YMD,
                                clickCallBack: (selectValue, selectIndexArr) {
                              print(selectValue);
                              print(selectIndexArr);
                              controller.selectPipeDiscloseDate.text =
                                  selectValue.split(' ')[0];
                            });
                          },
                          controller: controller.selectPipeDiscloseDate,
                        ),
                        CustomCell.input(
                          title: const Text('计划工期'),
                          hintText: '请输入计划工期',
                          suffix: const Text('天'),
                          controller: controller.inputDuration,
                        ),
                        CustomCell.input(
                          title: const Text('经纬度'),
                          hintText: '点击获取经纬度',
                          controller: controller.latAndLng,
                          readOnly: true,
                          onTap: () {
                            controller.latAndLng.text = '1,2';
                          },
                        ),
                        BuildFile(
                          title: '交底记录',
                          uploadedFiles: controller.selectDiscloseFiles,
                          toUploadFiles: controller.toDiscloseFiles,
                          onBefore: controller.uploadCoverBefore,
                          onAfter: controller.uploadAfterDiscloseFile,
                          onDelete: controller.uploadDelete,
                        ),
                        BuildFile(
                          title: '施工组织计划',
                          uploadedFiles: controller.selectPlanFiles,
                          toUploadFiles: controller.toPlanFiles,
                          onBefore: controller.uploadCoverBefore,
                          onAfter: controller.uploadAfterPlanFile,
                          onDelete: controller.uploadDelete,
                        ),
                      ],
                    ),
                  // 正在施工
                  if (controller.selectedStatus == 108)
                    CustomCellGroup(
                      isInset: false,
                      children: [
                        CustomCell.input(
                          title: const Text('开工日期'),
                          hintText: '请选择开工日期',
                          controller: controller.selectStartDate,
                          readOnly: true,
                          onTap: () {
                            JhPickerTool.showDatePicker(context,
                                dateType: PickerDateType.YMD,
                                clickCallBack: (selectValue, selectIndexArr) {
                              print(selectValue);
                              print(selectIndexArr);
                              controller.selectStartDate.text =
                                  selectValue.split(' ')[0];
                            });
                          },
                        ),
                        CustomCell.input(
                          title: const Text('停水开始时间'),
                          hintText: '请选择停水开始时间',
                          controller: controller.selectCutStartDateTime,
                          readOnly: true,
                          onTap: () {
                            JhPickerTool.showDatePicker(context,
                                dateType: PickerDateType.YMD_HM,
                                clickCallBack: (selectValue, selectIndexArr) {
                              print(selectValue);
                              print(selectIndexArr);
                              controller.selectCutStartDateTime.text =
                                  selectValue;
                            });
                          },
                        ),
                        CustomCell.input(
                          title: const Text('停水结束时间'),
                          hintText: '请选择停水结束时间',
                          controller: controller.selectCutEndDateTime,
                          readOnly: true,
                          onTap: () {
                            JhPickerTool.showDatePicker(context,
                                dateType: PickerDateType.YMD_HM,
                                clickCallBack: (selectValue, selectIndexArr) {
                              print(selectValue);
                              print(selectIndexArr);
                              controller.selectCutEndDateTime.text =
                                  selectValue;
                            });
                          },
                        ),
                        // CustomCell.input(
                        //   title: const Text('完成百分比'),
                        //   hintText: '请输入完成百分比',
                        //   controller: controller.inputPercent,
                        // ),

                        CustomCell.input(
                          title: const Text('完成百分比'),
                          hintText: '100',
                          suffix: const Text('%'),
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: false,
                            decimal: true,
                          ),
                          formatters: [
                            NumberInputFormatter(max: 100, decimal: 3),
                          ],
                          controller: controller.inputPercent,
                        ),

                        BuildFile(
                          title: '开工报告',
                          uploadedFiles: controller.selectStartFiles,
                          toUploadFiles: controller.toStartFiles,
                          onBefore: controller.uploadCoverBefore,
                          onAfter: controller.uploadAfterStartFile,
                          onDelete: controller.uploadDelete,
                        ),
                        BuildFile(
                          title: '工作量完成情况',
                          uploadedFiles: controller.selectPercentFiles,
                          toUploadFiles: controller.toPercentFiles,
                          onBefore: controller.uploadCoverBefore,
                          onAfter: controller.uploadAfterPercentFile,
                          onDelete: controller.uploadDelete,
                        ),
                        BuildFile(
                          title: '停水报告',
                          uploadedFiles: controller.selectCutFiles,
                          toUploadFiles: controller.toCutFiles,
                          onBefore: controller.uploadCoverBefore,
                          onAfter: controller.uploadAfterCutFile,
                          onDelete: controller.uploadDelete,
                        ),
                        BuildImg(
                          key: controller.clearKey2,
                          title: '文明施工图片',
                          uploadedAssets: controller.selectConstructFiles,
                          toUploadAssets: controller.toConstructFiles,
                          onBefore: controller.uploadCoverBefore,
                          onAfter: controller.uploadCoverAfterConstruct,
                          onDelete: controller.uploadCoverDeleteConstruct,
                        ),
                        BuildImg(
                          key: controller.clearKey3,
                          title: '管线现场图',
                          uploadedAssets: controller.selectPipeFiles,
                          toUploadAssets: controller.toPipeFiles,
                          onBefore: controller.uploadCoverBefore,
                          onAfter: controller.uploadCoverAfterPipe,
                          onDelete: controller.uploadCoverDeletePipe,
                        ),
                      ],
                    ),
                  // 完成施工
                  if (controller.selectedStatus == 109)
                    CustomCellGroup(
                      isInset: false,
                      children: [
                        CustomCell.input(
                          title: const Text('完工日期'),
                          hintText: '请选择完工日期',
                          controller: controller.selectEndDate,
                          readOnly: true,
                          onTap: () {
                            JhPickerTool.showDatePicker(context,
                                dateType: PickerDateType.YMD,
                                clickCallBack: (selectValue, selectIndexArr) {
                              print(selectValue);
                              print(selectIndexArr);
                              controller.selectEndDate.text =
                                  selectValue.split(' ')[0];
                            });
                          },
                        ),
                        CustomCell.input(
                          title: const Text('备注'),
                          hintText: '请输入备注',
                          controller: controller.inputDep,
                        ),
                        BuildFile(
                          title: '完工报告',
                          uploadedFiles: controller.selectEndFiles,
                          toUploadFiles: controller.toEndFiles,
                          onBefore: controller.uploadCoverBefore,
                          onAfter: controller.uploadAfterEndFile,
                          onDelete: controller.uploadDelete,
                        ),
                        BuildImg(
                          key: controller.clearKey1,
                          title: '完工图片',
                          uploadedAssets: controller.selectEndPicFiles,
                          toUploadAssets: controller.toEndPicFiles,
                          onBefore: controller.uploadCoverBefore,
                          onAfter: controller.uploadCoverAfterEndPic,
                          onDelete: controller.uploadCoverDeleteEndPic,
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  // 停止施工

                  // 签证信息
                  BuildVisas(
                    // key: controller.clearKey1,
                    visaValues: controller.selectVisaFiles,
                    toVisaValues: controller.toVisaFiles,
                    onChanged: controller.changeSKUs,
                    onAfter: controller.uploadAfterVisaFile,

                    readOnly: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
