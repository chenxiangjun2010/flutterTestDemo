/// @Description: 订单
/// @Author: 歪脖子
/// @Date: 2023-10-28 20:54

part of pages.video_log;

class VideoLogPage extends StatefulWidget {
  final String? id;
  const VideoLogPage({super.key, this.id});

  @override
  State<VideoLogPage> createState() => _VideoLogPageState(id);
}

class _VideoLogPageState extends State<VideoLogPage>
    with AutomaticKeepAliveClientMixin {
  final String? id;

  _VideoLogPageState(this.id);
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<VideoLogController>(
      tag: id,
      init: VideoLogController(id),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppTheme.primaryNavBarText),
          backgroundColor: const Color.fromRGBO(49, 85, 250, 1),
          title: const Text(
            '视频日志',
            style: TextStyle(color: AppTheme.primaryNavBarText),
          ),
          actions: const [
            // CustomButton(
            //   type: CustomButtonType.borderless,
            //   padding: const EdgeInsets.symmetric(horizontal: AppTheme.margin),
            //   onPressed: () => context.pushNamed(Routes.commodityDetail),
            //   child: const Text('新增'),
            // ),
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
                      final item = controller.logList[index];

                      return Padding(
                        padding: EdgeInsets.only(top: index != 0 ? 10 : 0),
                        child: BuildCard(
                          projectNum: item.projectNum,
                          projectOutNum: item.projectOutNum,
                          projectName: item.projectName,
                          deviceID: item.deviceID,
                          postTime: item.postTime,
                          id: item.id,
                          user: item.user,
                          isBind: item.isBind,
                          videoDeviceSFID: item.videoDeviceSFID,
                          title: item.title ?? '',
                        ),
                      );
                    },
                    itemCount: controller.logList.length,
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
