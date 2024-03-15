part of pages.project_detail;

class BuildFile extends StatefulWidget {
  final List<CommonFile> uploadedFiles;
  final List<CommonFile> toUploadFiles;
  final String? title;
  final bool? showAddBtn;
  final ValueChanged<File?>? onBefore;
  final ValueChanged<FileAllCommonModel?>? onAfter;
  final ValueChanged<CommonFile?>? onDelete;

  const BuildFile({
    super.key,
    this.showAddBtn = false,
    required this.uploadedFiles,
    required this.toUploadFiles,
    this.title,
    this.onBefore,
    this.onDelete,
    this.onAfter,
  });

  @override
  State<BuildFile> createState() => _BuildFileState();
}

class _BuildFileState extends State<BuildFile> {
  File? _file;
  bool _showMark = false;
  bool _isUploading = false;
  double _percentage = 0;

  Container _buildPhotoItem(CommonFile asset) {
    return Container(
        decoration: const BoxDecoration(
            // borderRadius: BorderRadius.circular(3),
            ),
        child: GestureDetector(
          onTap: () {
            print(1);
          },
          child: Text(
            (asset.filePath ?? '\\').split('\\')[1] ?? '',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ),
          ),
        ));
  }

  Widget _buildAddBtn(BuildContext context, double width) {
    return GestureDetector(
      onTap: () async {
        if (_isUploading) return;
        _isUploading = true;
        final asset = await getDocument();
        print('asset,$asset');

        if (asset == null) {
          _isUploading = false;
          return;
        }
        if (context.mounted) {
          setState(() {
            _file = File(asset);
            _showMark = true;
          });
        }
        // widget.onBefore?.call(_file);
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
          print('result,$result');

          widget.onAfter?.call(result);
        }
      },
      child: Container(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
        width: width,
        height: width,
        child: Icon(
          Icons.attach_file,
          size: 48,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //    final double width = (constraints.maxWidth - 10 * 3) / 4;
        // 标题
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ).copyWith(top: 16),
          child: DefaultTextStyle.merge(
            style: TextStyle(
              fontSize: 17,
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
        //   height: 6,
        // ),
        // 图片列表
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 18).copyWith(bottom: 16),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double width = (constraints.maxWidth - 10 * 3) / 4;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.uploadedFiles.length +
                              widget.toUploadFiles.length ==
                          0 ||
                      widget.showAddBtn == true)

                    // 选着图片按钮
                    _buildAddBtn(context, width),

                  const SizedBox(
                    height: 10,
                  ),

                  // 图片
                  if (widget.uploadedFiles.isNotEmpty)
                    for (final asset in widget.uploadedFiles)
                      _buildPhotoItem(asset),
                  for (final asset in widget.toUploadFiles)
                    _buildPhotoItem(asset),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
