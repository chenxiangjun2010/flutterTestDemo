part of pages.project_detail;

class VisaInfo extends StatefulWidget {
  final String title;
  final String id;
  final void Function(VisaList, FileAllCommonModel?) onAfter;
  const VisaInfo({
    super.key,
    required this.title,
    required this.id,
    required this.onAfter,
  });

  @override
  State<VisaInfo> createState() => _VisaInfoState();
}

class _VisaInfoState extends State<VisaInfo> {
  VisaList visaItem = VisaList();
  bool isEdit = false;
  final TextEditingController inputIntro = TextEditingController();

  List<CommonFile> toFiles = []; //施工组织计划 新增
  List<CommonFile> selectFiles = []; //item.files ?? []; //施工组织计划

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    print('_initDataID______________________________________________________,');
    print(widget.id);

    if (widget.id != '0') {
      visaItem = await ProjectBuildAPI.detailVisa(
        widget.id.toString(),
      );
      isEdit = true;
      print('editDate');
      print(visaItem.editDate);

      // init
      inputIntro.text = visaItem.intro ?? '';
      selectFiles = visaItem.files ?? [];
    }
    print('visaItem,$visaItem');
  }

  void onUploadAfter(FileAllCommonModel? value) {
    if (value == null) {
      return;
    }
    if (selectFiles.isNotEmpty) {
      // visaLists [bh]
      selectFiles.clear();
    }

    toFiles.clear();
    toFiles.add(CommonFile.fromJson({
      'filePath': value.filePath,
      'id': 0,
      'bh': value.bh,
    }));

    // widget.update();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              decoration: TextDecoration.underline,
            ),
          ),
          onPressed: () async {
            final result = await CustomBottomSheet.show(
              context: context,
              builder: (context) {
                return Column(children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('签证信息'),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: CustomCellGroup(
                      children: [
                        CustomCell.input(
                          title: const Text('签证概算'),
                          hintText: '',
                          controller: inputIntro,
                        ),
                        BuildFile(
                          title: '签字文件',
                          uploadedFiles: selectFiles,
                          toUploadFiles: toFiles,
                          showAddBtn: true,
                          onAfter: onUploadAfter,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          type: CustomButtonType.filled,
                          onPressed: () async {
                            if (inputIntro.text.trim() == '') {
                              CustomToast.text('请输入签证概算');
                              return;
                            }
                            if (toFiles.isEmpty) {
                              CustomToast.text('请上传文件');
                              return;
                            }
                            // 通知外层保存visa：bh
                            FileAllCommonModel? result;
                            List<String> toFilesStr = [];
                            for (final file in toFiles) {
                              toFilesStr.add(file.bh ?? '');
                            }

                            try {
                              result = await ProjectBuildAPI.updateVisa(
                                id: widget.id,
                                editDate: visaItem.editDate,
                                files: toFilesStr,
                                intro: inputIntro.text.trim(),
                              );
                            } catch (error) {
                              CustomToast.text('上传失败');
                            } finally {
                              print('result,$result');
                              VisaList visaItem = VisaList(
                                id: int.tryParse(widget.id),
                                files: toFiles,
                                intro: inputIntro.text,
                              );
                              if (context.mounted) {
                                widget.onAfter.call(visaItem, result);

                                Navigator.of(context).pop();
                                setState(() {});
                                _initData();
                              }
                            }
                          },
                          child: const Text('确认'),
                        )
                      ],
                    ),
                  ),
                ]);
              },
            );

            // try {
            //   await ProjectBuildAPI.deleteVisa(
            //     id: visaItem?.id ?? 0,
            //   );
            // } catch (error) {
            //   CustomToast.text('失败');
            // } finally {
            //   CustomToast.text('编辑成功');
            //   if (context.mounted) {
            //     setState(() {
            //       _visaValues.remove(visaItem);
            //     });
            //   }
            // }
          }),
    );
  }
}
