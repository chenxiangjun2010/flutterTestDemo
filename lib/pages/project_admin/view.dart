/// @Description: 订单
/// @Author: 歪脖子
/// @Date: 2023-10-28 20:54

part of pages.project_admin;

class ProjectAdminPage extends StatefulWidget {
  const ProjectAdminPage({super.key});

  @override
  State<ProjectAdminPage> createState() => _ProjectAdminPageState();
}

class _ProjectAdminPageState extends State<ProjectAdminPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    super.build(context);
    return GetBuilder<ProjectAdminController>(
      init: ProjectAdminController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primaryNavBarBg,
          elevation: 0,
          title: const Text(
            '工程施工',
            style: TextStyle(color: AppTheme.primaryNavBarText),
          ),
          actions: [
            CustomButton(
              type: CustomButtonType.borderless,
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.margin),
              onPressed: () async {
                final isEnd = await CustomBottomSheet.show(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('筛选条件'),
                            ),
                            const Divider(height: 0.5),
                            Expanded(
                              // width: double.infinity,

                              child: ListView(
                                // scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.all(10),
                                children: [
                                  // 内部编号
                                  CustomCell.input(
                                    title: const Text('工程名称'),
                                    hintText: '请输入工程名称',
                                    controller: controller.searchProjectName,
                                  ),
                                  CustomCell.input(
                                    title: const Text('内部编号'),
                                    hintText: '请输入内部编号',
                                    controller: controller.searchProjectNum,
                                  ),
                                  CustomCell.input(
                                    title: const Text('外部编号'),
                                    hintText: '请输入外部编号',
                                    controller: controller.searchProjectOutNum,
                                  ),
                                  Divider(
                                    height: 0.5,
                                  ),
                                  // // 施工状态
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          '施工状态',
                                          style: TextStyle(
                                              color: colorScheme.onTertiary),
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomRadioGroup<EnumModel>(
                                    items: controller.statusList,
                                    value: controller.status,
                                    rowCount: 3,
                                    builder: (index, item, isSelected) {
                                      return CustomChoose(
                                        value: isSelected,
                                        child: Text(item.name ?? '-'),
                                      );
                                    },
                                    onChanged: controller.changeStatus,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // 工程状态：
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          '工程状态',
                                          style: TextStyle(
                                              color: colorScheme.onTertiary),
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomRadioGroup<EnumModel>(
                                    items: controller.pstatusList,
                                    value: controller.pstatus,
                                    rowCount: 3,
                                    builder: (index, item, isSelected) {
                                      return CustomChoose(
                                        value: isSelected,
                                        child: Text(item.name ?? '-'),
                                      );
                                    },
                                    onChanged: controller.changePStatus,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // 退回状态：
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          '退回状态',
                                          style: TextStyle(
                                              color: colorScheme.onTertiary),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // pstatusList
                                  CustomRadioGroup<EnumModel>(
                                    items: controller.stateBackList,
                                    value: controller.stateBack,
                                    rowCount: 3,
                                    builder: (index, item, isSelected) {
                                      return CustomChoose(
                                        value: isSelected,
                                        child: Text(item.name ?? '-'),
                                      );
                                    },
                                    onChanged: controller.changeStateBack,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // 工程属地
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          '工程属地',
                                          style: TextStyle(
                                              color: colorScheme.onTertiary),
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomRadioGroup<EnumModel>(
                                    items: controller.placeList,
                                    value: controller.place,
                                    rowCount: 3,
                                    builder: (index, item, isSelected) {
                                      return CustomChoose(
                                        value: isSelected,
                                        child: Text(item.name ?? '-'),
                                      );
                                    },
                                    onChanged: controller.changePlace,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // 工程类别：
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          '工程类别',
                                          style: TextStyle(
                                              color: colorScheme.onTertiary),
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomRadioGroup<EnumModel>(
                                    items: controller.constractList,
                                    value: controller.constract,
                                    rowCount: 3,
                                    builder: (index, item, isSelected) {
                                      return CustomChoose(
                                        value: isSelected,
                                        child: Text(item.name ?? '-'),
                                      );
                                    },
                                    onChanged: controller.changeConstract,
                                  ),

                                  SizedBox(
                                    height: 30,
                                  ),
                                  // 停水状态
                                  CustomRadioGroup<EnumModel>(
                                    items: controller.bstateList,
                                    value: controller.bstate,
                                    rowCount: 3,
                                    builder: (index, item, isSelected) {
                                      return CustomChoose(
                                        value: isSelected,
                                        child: Text(item.name ?? '-'),
                                      );
                                    },
                                    onChanged: controller.changeBState,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      shape: CustomButtonShape.radius,
                                      type: CustomButtonType.opacity,
                                      // padding: const EdgeInsets.symmetric(
                                      //     horizontal: AppTheme.margin,
                                      //     vertical: 8),
                                      fontSize: 14,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        controller.reset();
                                      },
                                      child: const Text(
                                        '重置',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: CustomButton(
                                      shape: CustomButtonShape.radius,
                                      type: CustomButtonType.filled,
                                      // padding: const EdgeInsets.symmetric(
                                      //     horizontal: AppTheme.margin,
                                      //     vertical: 8),
                                      fontSize: 14,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        controller.search();
                                      },
                                      child: const Text(
                                        '确定',
                                      ),
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      );
                    });
              },
              child: const Icon(
                Icons.search,
                size: 28,
                color: AppTheme.primaryNavBarText,
              ),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              // Color.fromRGBO(28, 56, 253, 1),
              Color(0xFF3155FA),
              Color.fromRGBO(78, 126, 246, 1),
              Color.fromRGBO(180, 218, 250, 1),
              Color.fromRGBO(242, 242, 242, 1)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.clamp,
          )),
          child: CustomPullScrollView(
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            builder: (context, physics) => CustomScrollView(
              physics: physics,
              slivers: [
                SliverSafeArea(
                  bottom: false,
                  minimum: const EdgeInsets.all(
                    AppTheme.margin,
                  ).copyWith(bottom: 0),
                  sliver: SliverList.builder(
                    itemBuilder: (BuildContext context, int index) {
                      final item = controller.dataList[index];

                      return Padding(
                        padding: EdgeInsets.only(top: index != 0 ? 10 : 0),
                        child: BuildCard(
                          startDate: item.startDate,
                          endDate: item.endDate,
                          bStateName: item.bStateName,
                          bStatusName: item.bStatusName,
                          placeName: item.placeName,
                          statusName: item.statusName,
                          stateName: item.stateName,
                          deviceID: item.deviceID,
                          deviceUser: item.bStatusName,
                          projectNum: item.projectNum,
                          projectOutNum: item.projectOutNum,
                          projectName: item.projectName,
                          userPhone: item.placeName,
                          sfid: item.bStatus,
                          id: item.id,
                          projectID: item.projectID,
                          setting: item.setting ?? '',
                        ),
                      );
                    },
                    itemCount: controller.dataList.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
