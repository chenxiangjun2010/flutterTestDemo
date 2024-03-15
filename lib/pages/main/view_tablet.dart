/// @Description: 平板端视图
/// @Author: 歪脖子
/// @Date: 2023-11-06 23:45

part of pages.main;

class MainForTablet extends StatelessWidget {
  const MainForTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) => Scaffold(
        body: Row(
          children: [
            SizedBox(
              width: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppBar(title: const FlutterLogo()),
                  Expanded(
                    child: GetBuilder<MainController>(
                      id: 'navigation',
                      builder: (controller) => BuildNavigationBarForTablet(
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
                          // BottomNavigationBarItem(
                          //   icon: Icon(Icons.note_alt_rounded),
                          //   label: '订单',
                          // ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.more_horiz_rounded),
                            label: '更多',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: UnconstrainedBox(
                      child: CustomButton(
                        width: 45,
                        height: 45,
                        padding: EdgeInsets.zero,
                        type: CustomButtonType.filled,
                        child: const Icon(Icons.redeem_rounded, size: 24),
                        onPressed: () {
                          controller.pageController.jumpToPage(4);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: const [
                  // HomePage(),
                  // CommodityPage(),
                  // OrderPage(),
                  // SettingPage(),
                  // SettlePage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
