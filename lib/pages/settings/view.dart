/// @Description: 更多设置页面
/// @Author: 歪脖子
/// @Date: 2023-10-18 00:54

part of pages.settings;

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  // static const AMapApiKey amapApiKeys =
  //     AMapApiKey(iosKey: 'XXXXXXXX', androidKey: 'XXXXXX');
  // AMapController? mapController;
  // final Map<String, Marker> _initMakerMap = <String, Marker>{};
  // Latlng centerRiderLatLng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryNavBarBg,
        title: const Text(
          '设置',
          style: TextStyle(color: AppTheme.primaryNavBarText),
        ),
        actions: const [],
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFF3155FA),
            // Color.fromRGBO(78, 126, 246, 1),
            // Color.fromRGBO(78, 126, 246, 1),
            Color.fromRGBO(180, 218, 250, 1),
            Color.fromRGBO(242, 242, 242, 1)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.clamp,
        )),
        child: SingleChildScrollView(
          child: SafeArea(
            minimum: const EdgeInsets.all(AppTheme.margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                    child: Text(
                      '获取位置',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.8),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: () async {
                      // final result = await CustomBottomSheet.show(
                      //     context: context,
                      //     builder: (context) {
                      //       return Center(
                      //         child: Container(
                      //           margin: EdgeInsets.only(bottom: 10),
                      //           child: AMapWidget(
                      //             apiKey: amapApiKeys,
                      //             markers: Set<Marker>.of(_initMakerMap.values),
                      //             initialCameraPosition: CameraPosition(
                      //                 target: centerRiderLatLng, zoom: 14),
                      //             // 普通地图normal,卫星地图satellite,夜间视图night,导航视图 navi,公交视图bus,
                      //             mapType: MapType.navi,
                      //             // 缩放级别范围
                      //             minMaxZoomPreference:
                      //                 const MinMaxZoomPreference(3, 20),
                      //             // 隐私政策包含高德 必须填写
                      //             privacyStatement: const AMapPrivacyStatement(
                      //                 hasAgree: true,
                      //                 hasContains: true,
                      //                 hasShow: true),
                      //             // 地图创建成功时返回AMapController
                      //             onMapCreated: (AMapController controller) {
                      //               mapController = controller;
                      //             },
                      //           ),
                      //         ),
                      //       );
                      //     });
                    }),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Image(
                        image: AssetImage('assets/images/avatar.png'),
                        height: 84,
                        width: 84,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    UserStore.to.info.name ?? '',
                                    style: const TextStyle(
                                      fontFamily: 'number',
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  DecoratedBox(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFE2EBFD),
                                    ),
                                    child: Text(
                                      UserStore.to.info.isBgUser == false
                                          ? '总工程师'
                                          : '工程师',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          height: 1.5,
                                          color: Color(0xFF0A60D9)),
                                    ),
                                  ),
                                  // Container(
                                  //   color: Colors.amber,
                                  //   child: Text(
                                  //     UserStore.to.info.isBgUser == false
                                  //         ? '总工程师'
                                  //         : '工程师',
                                  //     style: const TextStyle(
                                  //       fontFamily: 'number',
                                  //       fontSize: 14,
                                  //       height: 1.5,
                                  //     ),
                                  //   ),
                                  // )
                                ]),
                            const SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const CustomCellGroup(
                  children: [
                    // CustomCell(
                    //   title: const Text('标签打印'),
                    //   onTap: () => context.pushNamed(Routes.labelPrint),
                    // ),
                    // CustomCell(
                    //   title: const Text('视频设备管理'),
                    //   onTap: () => context.pushNamed(Routes.videoAdmin),
                    // ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomButton(
                  foregroundColor: AppTheme.primary,
                  onPressed: () async {
                    await UserStore.to.logout();
                    if (!context.mounted) return;
                    context.goNamed(Routes.main);
                  },
                  child: const Text('退出'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
