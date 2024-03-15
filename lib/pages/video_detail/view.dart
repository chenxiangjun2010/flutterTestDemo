part of pages.video_detail;

class VideoDetailPage extends StatelessWidget {
  final String? id;

  const VideoDetailPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommodityDetailController>(
      tag: id,
      init: CommodityDetailController(id),
      builder: (controller) => GestureDetector(
        onTap: () => Tools.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppTheme.primaryNavBarText),
            backgroundColor: const Color.fromRGBO(49, 85, 250, 1),
            title: Text(
              controller.isEdit ? '编辑视频设备' : '新增视频设备',
              style: TextStyle(color: AppTheme.primaryNavBarText),
            ),
            actions: [],
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              minimum: const EdgeInsets.all(AppTheme.margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomCellGroup(
                    isInset: false,
                    children: [
                      CustomCell.input(
                        title: const Text('所在工程'),
                        hintText: '请选择所在工程',
                        readOnly: true,
                        onTap: () {
                          JhPickerTool.showStringPicker(context,
                              data: controller.prjNameList,
                              selectIndex: controller.activePrjIndex ?? 0,
                              clickCallBack: (selectValue, selectIndex) {
                            print(selectValue);
                            controller.selectProjectName.text =
                                selectValue ?? '';
                            controller.activePrjIndex = selectIndex;
                            controller.projectID =
                                controller.seasonList[selectIndex].id;
                          });
                        },
                        controller: controller.selectProjectName,
                      ),
                      CustomCell.input(
                        title: const Text('设备ID'),
                        hintText: '请输入设备ID',
                        controller: controller.deviceID,
                      ),
                      CustomCell.input(
                        title: const Text('设备名称'),
                        hintText: '请输入设备名称',
                        controller: controller.deviceName,
                      ),
                      CustomCell.input(
                        title: const Text('使用人'),
                        hintText: '请输入使用人',
                        controller: controller.deviceUser,
                      ),
                      CustomCell.input(
                        title: const Text('联系方式'),
                        hintText: '请输入联系方式',
                        controller: controller.userPhone,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      Tools.unfocus();
                      await controller.submit(context);
                    },
                    child: const Text(
                      '确定',
                      style: TextStyle(
                        color: AppTheme.primaryNavBarText,
                      ),
                    ),
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
