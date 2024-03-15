part of pages.project_detail;

class BuildVisas extends StatefulWidget {
  final bool readOnly;
  final List<VisaList> visaValues;
  final List<CommonFile> toVisaValues;
  final ValueChanged<List<CommoditySKUModel>>? onChanged;
  final ValueChanged<FileAllCommonModel?> onAfter;

  const BuildVisas({
    super.key,
    required this.visaValues,
    required this.toVisaValues,
    this.onChanged,
    required this.onAfter,
    this.readOnly = false,
  });

  @override
  State<BuildVisas> createState() => _BuildVisasState();
}

class _BuildVisasState extends State<BuildVisas> {
  List<VisaList> _visaValues = [];

  @override
  void initState() {
    _visaValues = widget.visaValues;
    // if (_colorValues.isEmpty) _colorValues.add(widget.colors.first);
    _generated();
    initPatformState();

    super.initState();
  }

  Future<void> initPatformState() async {
    _setPath();
    if (!context.mounted) return;
  }

  void _setPath() async {
    Directory path = await getApplicationDocumentsDirectory();
    String localPath = '${path.path}${Platform.pathSeparator}Download';
    final savedDir = Directory(localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    // path = localPath as Directory;
    print('path_________________________________________,$path');
  }

  void _launchURL(String path) async {
    print('path,$path');
    Uri url = Uri.file('$kServerUrl/$path'); //'$kServerUrl/$path'
    print('url,$url');
    // if (await canLaunchUrl(url)) {
    //   // 判断当前手机是否安装某app. 能否正常跳转
    //   await launchUrl(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  @override
  void didUpdateWidget(covariant BuildVisas oldWidget) {
    _visaValues = widget.visaValues;
    // if (_colorValues.isEmpty) _colorValues.add(widget.colors.first);
    _generated();
    super.didUpdateWidget(oldWidget);
  }

  void _generated() {
    setState(() {});
    // widget.onChanged?.call(_selec);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          CustomCellGroup(
            title: const Text('签证信息'),
            more: CustomPopup(
              content: const _SKUSelect(),
              child: VisaInfo(
                  title: '添加签证信息', id: '0', onAfter: _onAfterUpdateItem),
            ),
            children: List.generate(_visaValues.length, (index) {
              final item = _visaValues[index];

              return Container(
                // padding: EdgeInsets.only(left: 6, right: 6, bottom: 2, top: 4),
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.04)),
                child: CustomCellGroup(
                  showDivider: false,
                  isInset: false,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    CustomCell(
                      onTap: () async {},
                      showArrow: false,
                      title: const Text('签证概算'),
                      // titleStyle: const TextStyle(
                      //   fontSize: 15,
                      // ),
                      // valueStyle: TextStyle(
                      //   fontSize: 15,
                      // ),
                      value: CustomAnimatedSwitcher(
                        child: Text(item.intro ?? ''),
                      ),
                    ),
                    CustomCell(
                      // onTap: () => _changeValue(item, isSelected),
                      showArrow: false,
                      title: const Text('签证文件'),
                      // titleStyle: TextStyle(
                      //   fontSize: 15,
                      // ),
                      // valueStyle: TextStyle(
                      //   fontSize: 15,
                      // ),
                      value: CustomAnimatedSwitcher(
                        child: GestureDetector(
                          onTap: () =>
                              _launchURL(item.files?[0].filePath ?? '\\'),
                          child: Text(
                            (item.files?[0].filePath ?? '\\').split('\\')[1],
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () async {
                            final canDelete = await CustomDialog.show<bool>(
                              context: context,
                              builder: (context) => const Text('是否删除？'),
                              cancel: const Text('取消'),
                              confirm: const Text('确定'),
                              onCancel: Navigator.of(context).pop,
                              onConfirm: () => Navigator.of(context).pop(true),
                            );
                            if (canDelete != true) {
                              return;
                            }
                            try {
                              await ProjectBuildAPI.deleteVisa(
                                id: item.id ?? 0,
                              );
                            } catch (error) {
                              CustomToast.text('删除失败');
                            } finally {
                              CustomToast.text('删除成功');
                              if (context.mounted) {
                                setState(() {
                                  _visaValues.remove(item);
                                });
                              }
                            }
                          },
                          child: Text(
                            '删除',
                            style: TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                color: Theme.of(context).colorScheme.error),
                          ),
                        ),
                        VisaInfo(
                            title: '编辑',
                            id: item.id.toString(),
                            onAfter: _onAfterUpdateItem),
                      ],
                    )
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _onAfterUpdateItem(VisaList visaItem, FileAllCommonModel? file) {
    print('_______________________________________________________file,$file');
    print('visaItem,$visaItem');
    print(visaItem.id);
    print(visaItem.files);
    print('_visaValues,$_visaValues');
    if (visaItem.id == 0) {
      _visaValues.add(visaItem);
      widget.onAfter.call(file); //ADD
      print(_visaValues.length);
    } else {
      _visaValues[_visaValues
          .indexWhere((element) => element.id == visaItem.id)] = visaItem;
    }
    setState(() {});
  }
}

class _SKUSelect extends StatefulWidget {
  const _SKUSelect({
    Key? key,
  }) : super(key: key);

  @override
  State<_SKUSelect> createState() => _SKUSelectState();
}

class _SKUSelectState extends State<_SKUSelect> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _SKUSelect oldWidget) {
    // _colorValues = [...widget.colorValues];
    // _sizeValues = [...widget.sizeValues];
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: SingleChildScrollView(
        child: DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('颜色'),
            ],
          ),
        ),
      ),
    );
  }
}
