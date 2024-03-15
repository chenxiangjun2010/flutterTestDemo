/// @Description: 手机端视图
/// @Author: 歪脖子
/// @Date: 2023-11-06 23:25

part of pages.main;

class MainForMobile extends StatelessWidget {
  const MainForMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) => Scaffold(
        extendBody: true,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          onPageChanged: controller.onPageChanged,
          children: const [
            // HomePage(),
            ProjectAdminPage(),
            VideoAdminPage(),
            SettingPage(),
          ],
        ),
        // floatingActionButton: CustomButton(
        //   width: 55,
        //   height: 55,
        //   padding: EdgeInsets.zero,
        //   type: CustomButtonType.filled,
        //   child: const Icon(Icons.redeem_rounded, size: 30),
        //   onPressed: () => context.pushNamed(Routes.settle),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: GetBuilder<MainController>(
          id: 'navigation',
          builder: (controller) => BuildNavigationBar(
            currentIndex: controller.currentPage,
            onTap: controller.pageController.jumpToPage,
            items: const [
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.broken_image_rounded),
              //   label: '概述',
              // ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.shopping_bag_rounded),
              //   label: '商品',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.note_alt_rounded),
                label: '工程工程',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.video_camera_front_rounded),
                label: '视频管理',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.login_rounded),
                label: '设置',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
