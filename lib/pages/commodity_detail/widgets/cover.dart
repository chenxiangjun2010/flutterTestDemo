part of pages.commodity_detail;

class BuildCover extends StatefulWidget {
  final String? url;
  final ValueChanged<File?>? onBefore;
  final ValueChanged<String?>? onAfter;

  const BuildCover({
    super.key,
    this.url,
    this.onBefore,
    this.onAfter,
  });

  @override
  State<BuildCover> createState() => _BuildCoverState();
}

class _BuildCoverState extends State<BuildCover> {
  File? _file;
  bool _showMark = false;
  bool _isUploading = false;
  final double _percentage = 0;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(0),
      clipBehavior: Clip.hardEdge,
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
        String? result;
        try {
          // result = await CommonAPI.upload(
          //   path: _file!.path,
          //   onSendProgress: (count, total) {
          //     _percentage = 0.0;
          //     if (total <= 0) return;
          //     if (context.mounted) {
          //       setState(() {
          //         _percentage = count / total * 100;
          //       });
          //     }
          //   },
          // );
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
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          _file != null
              ? CustomImage.file(url: _file!.path, radius: 0)
              : CustomImage.network(
                  url: widget.url ?? '',
                  radius: 0,
                  error: (widget.url ?? '').isEmpty
                      ? const Icon(Icons.add_photo_alternate_outlined)
                      : null,
                ),
          if (_showMark)
            Positioned.fill(
              child: FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                heightFactor: 1 - (_percentage / 100),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
