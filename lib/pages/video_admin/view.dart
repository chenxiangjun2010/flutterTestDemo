/// @Description: 订单
/// @Author: 歪脖子
/// @Date: 2023-10-28 20:54

part of pages.video_admin;

class VideoAdminPage extends StatefulWidget {
  const VideoAdminPage({super.key});

  @override
  State<VideoAdminPage> createState() => _VideoAdminPageState();
}

class _VideoAdminPageState extends State<VideoAdminPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<VideoAdminController>(
      init: VideoAdminController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primaryNavBarBg,
          title: const Text(
            '视频设备',
            style: TextStyle(color: AppTheme.primaryNavBarText),
          ),
          actions: [
            CustomButton(
                type: CustomButtonType.borderless,
                padding:
                    const EdgeInsets.symmetric(horizontal: AppTheme.margin),
                onPressed: () => context.pushNamed(Routes.videoDetail),
                child: const Icon(
                  Icons.add,
                  size: 32,
                  color: AppTheme.primaryNavBarText,
                )),
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
                                    title: const Text('设备ID'),
                                    hintText: '请输入设备ID',
                                    controller: controller.searchDeivceId,
                                  ),
                                  CustomCell.input(
                                    title: const Text('设备名称'),
                                    hintText: '请输入设备名称',
                                    controller: controller.searchDeivceName,
                                  ),
                                  CustomCell.input(
                                    title: const Text('使用人'),
                                    hintText: '请输入使用人',
                                    controller: controller.searchUserName,
                                  ),
                                  Divider(
                                    height: 0.5,
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
                      final item = controller.videoList[index];

                      return Padding(
                        padding: EdgeInsets.only(top: index != 0 ? 10 : 0),
                        child: BuildCard(
                          dateTime: item.editDate,
                          deviceName: item.deviceName,
                          deviceUser: item.deviceUser,
                          projectNum: item.projectNum,
                          projectOutNum: item.projectOutNum,
                          projectName: item.projectName,
                          userPhone: item.userPhone,
                          deviceID: item.deviceID,
                          sfid: item.sfid,
                          id: item.id,
                          setting: item.setting ?? '',
                        ),
                      );
                    },
                    itemCount: controller.videoList.length,
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
