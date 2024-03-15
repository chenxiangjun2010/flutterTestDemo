part of pages.project_detail;

class BuildImg extends StatefulWidget {
  // final String? url;
  final String? title;
  final ValueChanged<File?>? onBefore;
  final ValueChanged<FileAllCommonModel?>? onAfter;
  final ValueChanged<CommonFile?>? onDelete;
  final List<CommonFile> uploadedAssets;
  final List<CommonFile> toUploadAssets;

  const BuildImg({
    super.key,
    // this.url,
    this.title,
    required this.uploadedAssets,
    required this.toUploadAssets,
    this.onBefore,
    this.onDelete,
    this.onAfter,
  });

  @override
  State<BuildImg> createState() => _BuildImgState();
}

class _BuildImgState extends State<BuildImg> {
  File? _file;
  bool _showMark = false;
  bool _isUploading = false;
  double _percentage = 0;

  // photo-preview
  Widget _buildImageView(asset) {
    return CustomImage.network(
      url: '$kServerUrl/${asset.filePath ?? ''}',
      radius: 0,
      fit: BoxFit.cover,
      backgroundColor: Colors.black45,
      error: (asset.filePath ?? '').isEmpty
          ? const Icon(Icons.add_photo_alternate_outlined)
          : null,
    );
  }

  Container _buildPhotoItem(CommonFile asset, double width) {
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
        ),
        child: GestureDetector(
          onTap: () {
            //
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('预览'),
                    actions: const [
                      // CustomButton(
                      //   type: CustomButtonType.borderless,
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: AppTheme.margin,
                      //   ),
                      //   onPressed: () async {},
                      //   child: const Text('完成'),
                      // ),
                    ],
                  ),
                  body: _buildImageView(asset),
                );
              },
            ));
          },
          onLongPress: () async {
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
            widget.onDelete?.call(asset);
          },
          child: CustomImage.network(
            url: '$kServerUrl/${asset.filePath ?? ''}',
            radius: 0,
            width: width,
            height: width,
            error: (asset.filePath ?? '').isEmpty
                ? Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : null,
          ),
        ));
  }

  Widget _buildAddBtn(BuildContext context, double width) {
    return GestureDetector(
      onTap: () async {
        if (_isUploading) return;
        _isUploading = true;
        final asset = await AssetsPicker.image(context: context);
        if (asset == null) {
          _isUploading = false;
          return;
        }
        if (context.mounted) {
          setState(() {
            _file = asset;
            _showMark = true;
          });
        }
        widget.onBefore?.call(_file);
        print('_file,$_file');

        FileAllCommonModel? result;
        try {
          result = await CommonAPI.upload(
            path: _file!.path,
            onSendProgress: (count, total) {
              _percentage = 0.0;
              if (total <= 0) return;
              if (context.mounted) {
                setState(() {
                  _percentage = count / total * 100;
                });
              }
            },
          );
        } catch (error) {
          CustomToast.text('上传失败');
        } finally {
          _isUploading = false;
          if (context.mounted) {
            setState(() {
              _showMark = false;
            });
          }
          widget.onAfter?.call(result);
        }

        // setState(() {
        //   uploadedAssets = result ?? [];
        // });
      },
      child: Container(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
        width: width,
        height: width,
        child: Icon(
          Icons.add,
          size: 48,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        ),
      ),
    );
  }

  // Widget _buildPhotosList() {
  //   return Padding(
  //     padding: const EdgeInsets.all(10),
  //     child: LayoutBuilder(
  //       builder: (BuildContext context, BoxConstraints constraints) {
  //         final double width = (constraints.maxWidth - 10 * 2) / 3;
  //         return Wrap(
  //           spacing: 10,
  //           runSpacing: 10,
  //           children: [
  //             // 图片
  //             for (final asset in uploadedAssets) _buildPhotoItem(asset, width),

  //             // 选着图片按钮
  //             _buildAddBtn(context, width),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ).copyWith(top: 10),
          child: DefaultTextStyle.merge(
            style: TextStyle(
              // fontSize: 17,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title ?? ''),
              ],
            ),
          ),
        ),
        // SizedBox(
        //   height: 2,
        // ),
        // 图片列表
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double width = (constraints.maxWidth - 10 * 3) / 4;

              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  // 图片
                  for (final asset in widget.uploadedAssets)
                    _buildPhotoItem(asset, width),
                  for (final asset in widget.toUploadAssets)
                    _buildPhotoItem(asset, width),
                  // 选着图片按钮
                  _buildAddBtn(context, width),
                ],
              );
            },
          ),
        ),
        const SizedBox(
          height: 6,
        ),
      ],
    );
    // CustomCard(
    // width: 100,
    // height: 100,
    // padding: const EdgeInsets.all(0),
    // clipBehavior: Clip.hardEdge,
    // onTap: () async {
    // if (_isUploading) return;
    // _isUploading = true;
    // final asset = await AssetsPicker.image(context: context);
    // if (asset == null) {
    //   _isUploading = false;
    //   return;
    // }
    // if (context.mounted) {
    //   setState(() {
    //     _file = asset;
    //     _showMark = true;
    //   });
    // }
    // widget.onBefore?.call(_file);
    // String? result;
    // try {
    //   result = await CommonAPI.upload(
    //     path: _file!.path,
    //     onSendProgress: (count, total) {
    //       _percentage = 0.0;
    //       if (total <= 0) return;
    //       if (context.mounted) {
    //         setState(() {
    //           _percentage = count / total * 100;
    //         });
    //       }
    //     },
    //   );
    // } catch (error) {
    //   CustomToast.text('上传失败');
    // } finally {
    //   _isUploading = false;
    //   if (context.mounted) {
    //     setState(() {
    //       _showMark = false;
    //     });
    //   }
    //   widget.onAfter?.call(result);
    // }
    // },
    // child: Stack(
    //   fit: StackFit.expand,
    //   children: [
    //     _file != null
    //         ? CustomImage.file(url: _file!.path, radius: 0)
    //         : CustomImage.network(
    //             url: widget.url ?? '',
    //             radius: 0,
    //             error: (widget.url ?? '').isEmpty
    //                 ? const Icon(Icons.add_photo_alternate_outlined)
    //                 : null,
    //           ),
    //     if (_showMark)
    //       Positioned.fill(
    //         child: FractionallySizedBox(
    //           alignment: Alignment.bottomCenter,
    //           heightFactor: 1 - (_percentage / 100),
    //           child: DecoratedBox(
    //             decoration: BoxDecoration(
    //               color: Colors.black.withOpacity(0.5),
    //             ),
    //           ),
    //         ),
    //       ),
    //   ],
    // ),
    // );
  }
}
