part of pages.commodity_detail;

class CommodityDetailPage extends StatelessWidget {
  final String? id;

  const CommodityDetailPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommodityDetailController>(
      tag: id,
      init: CommodityDetailController(id),
      builder: (controller) => GestureDetector(
        onTap: () => Tools.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(controller.isEdit ? '编辑商品' : '新增商品'),
            actions: [
              CustomButton(
                type: CustomButtonType.borderless,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.margin,
                ),
                onPressed: () async {
                  Tools.unfocus();
                  await controller.submit(context);
                  if (controller.isEdit ||
                      LabelStore.to.layout?.size == null ||
                      LabelStore.to.contents.isEmpty) {
                    return;
                  }
                  if (!context.mounted) return;
                  // final canPrint = await CustomDialog.show<bool>(
                  //   context: context,
                  //   builder: (context) => const Text('是否开始打印？'),
                  //   cancel: const Text('取消'),
                  //   confirm: const Text('打印'),
                  //   onCancel: Navigator.of(context).pop,
                  //   onConfirm: () => Navigator.of(context).pop(true),
                  // );
                  // if (canPrint != true) {
                  //   controller.printData = null;
                  //   return;
                  // }
                  // if (controller.startPrint() != true) return;
                  // if (!context.mounted) return;
                  // final isEnd = await CustomBottomSheet.showPrintTask(
                  //   context: context,
                  //   stream: PrinterService.to.printingCountStream,
                  //   page: PrinterService.to.printPage,
                  // );
                  // if (isEnd == true) PrinterService.to.endPrint();
                },
                child: const Text('完成'),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              minimum: const EdgeInsets.all(AppTheme.margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      BuildCover(
                        key: controller.clearKey,
                        url: controller.detail.cover,
                        onBefore: controller.uploadCoverBefore,
                        onAfter: controller.uploadCoverAfter,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomCellGroup(
                          children: [
                            CustomCell.input(
                              title: const Text('名称'),
                              hintText: '请输入',
                              controller: controller.inputName,
                            ),
                            CustomCell.input(
                              title: const Text('款号'),
                              hintText: '默认自动生成',
                              controller: controller.inputCode,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BuildSKU(
                    key: controller.clearKey,
                    colors: kDefaultColors,
                    sizes: kDefaultSizes,
                    colorValues: controller.colorValues,
                    sizeValues: controller.sizeValues,
                    onChanged: controller.changeSKUs,
                    onColorsChanged: controller.changeColors,
                    onSizesChanged: controller.changeSizes,
                    readOnly: controller.isEdit,
                  ),
                  const SizedBox(height: 20),
                  CustomCellGroup(
                    children: [
                      CustomCell.input(
                        title: const Text('成本价'),
                        hintText: '请输入',
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: false,
                          decimal: true,
                        ),
                        formatters: [NumberInputFormatter()],
                        controller: controller.inputEntryPrice,
                      ),
                      CustomCell.input(
                        title: const Text('零售价'),
                        hintText: '请输入',
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: false,
                          decimal: true,
                        ),
                        formatters: [NumberInputFormatter()],
                        controller: controller.inputPrice,
                      ),
                      CustomCell.input(
                        title: const Text('折扣'),
                        hintText: '100',
                        suffix: const Text('%'),
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: false,
                          decimal: true,
                        ),
                        formatters: [
                          NumberInputFormatter(max: 100, decimal: 0),
                        ],
                        controller: controller.inputDiscount,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GetBuilder<CommodityDetailController>(
                    tag: id,
                    id: 'season_list',
                    builder: (controller) {
                      return CustomRadioGroup<CommodityAttrModel>(
                        items: controller.seasonList,
                        value: controller.season,
                        rowCount: 4,
                        builder: (index, item, isSelected) {
                          return CustomChoose(
                            value: isSelected,
                            child: Text(item.name ?? '-'),
                          );
                        },
                        onChanged: controller.changeSeason,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomCellGroup(
                    children: [
                      CustomCell.input(
                        title: const Text('条码'),
                        hintText: '默认自动生成',
                        readOnly: true,
                        controller: controller.inputBarcode,
                        suffix: CustomButton(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          type: CustomButtonType.borderless,
                          size: CustomButtonSize.small,
                          onPressed: controller.changeBarcode,
                          child: const Text('生成'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomCellGroup(
                    children: [
                      CustomCell(
                        title: const Text('上架'),
                        value: CustomSwitch(
                          enable: controller.isEdit,
                          value: controller.isSales,
                          onChanged: controller.changeSales,
                        ),
                      ),
                    ],
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
