part of pages.commodity;

class CommodityPage extends StatefulWidget {
  const CommodityPage({super.key});

  @override
  State<CommodityPage> createState() => _CommodityPageState();
}

class _CommodityPageState extends State<CommodityPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<CommodityController>(
      init: CommodityController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('商品管理'),
          actions: [
            CustomButton(
              type: CustomButtonType.borderless,
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.margin),
              onPressed: () => context.pushNamed(Routes.commodityDetail),
              child: const Text('新增'),
            ),
          ],
        ),
        body: CustomPullScrollView(
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
                    final item = controller.commodityList[index];
                    return Padding(
                      padding: EdgeInsets.only(top: index != 0 ? 10 : 0),
                      child: BuildGoods(
                        cover: item.cover,
                        name: item.name,
                        code: item.code,
                        stock: item.stock,
                        price: item.price,
                        isSales: item.isSales ?? false,
                        onTap: () => context.pushNamed(
                          Routes.commodityDetail,
                          queryParameters: {'id': item.id},
                        ),
                        onShelves: () async => controller.onShelves(item.id),
                        onRemove: () => controller.onRemove(item.id),
                        onStock: () async {
                          if (item.id == null) return;
                          final result = await CustomBottomSheet.showStock(
                            context: context,
                            cover: item.cover,
                            name: item.name,
                            code: item.code,
                            data: () async => StockAPI.goods(item.id!),
                          );
                          if (result == null) return;
                          controller.changeStock(item, result);
                        },
                      ),
                    );
                  },
                  itemCount: controller.commodityList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
