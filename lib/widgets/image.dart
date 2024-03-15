part of widgets;

enum CustomImageType { asset, network, file, base64 }

class CustomImage extends StatelessWidget {
  final String url;
  final Widget? placeholder;
  final Widget? error;
  final CustomImageType type;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit fit;
  final Color? backgroundColor;
  final ExtendedImageMode mode;
  final bool enableSlideOutPage;
  final InitGestureConfigHandler? initGestureConfig;
  final Widget Function(
    BuildContext context,
    ImageProvider provider,
    Widget completed,
    Size? size,
  )? builder;

  const CustomImage({
    Key? key,
    required this.url,
    required this.type,
    this.width,
    this.height,
    this.radius,
    this.fit = BoxFit.cover,
    this.builder,
    this.mode = ExtendedImageMode.none,
    this.enableSlideOutPage = false,
    this.initGestureConfig,
    this.backgroundColor,
    this.placeholder,
    this.error,
  }) : super(key: key);

  const CustomImage.network({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.radius,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.placeholder,
    this.error,
    this.builder,
  })  : type = CustomImageType.network,
        mode = ExtendedImageMode.none,
        enableSlideOutPage = false,
        initGestureConfig = null,
        super(key: key);

  const CustomImage.asset({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.radius,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.placeholder,
    this.error,
    this.builder,
  })  : type = CustomImageType.asset,
        mode = ExtendedImageMode.none,
        enableSlideOutPage = false,
        initGestureConfig = null,
        super(key: key);

  const CustomImage.file({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.radius,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.placeholder,
    this.error,
    this.builder,
  })  : type = CustomImageType.file,
        mode = ExtendedImageMode.none,
        enableSlideOutPage = false,
        initGestureConfig = null,
        super(key: key);

  const CustomImage.base64({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.radius,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.placeholder,
    this.error,
    this.builder,
  })  : type = CustomImageType.base64,
        mode = ExtendedImageMode.none,
        enableSlideOutPage = false,
        initGestureConfig = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.all(Radius.circular(radius ?? 10));
    final Widget errorChild =
        error ?? const Icon(Icons.image_not_supported_outlined);
    final Widget placeholderChild =
        placeholder ?? const CupertinoActivityIndicator(radius: 12);
    Widget? image;
    switch (type) {
      case CustomImageType.asset:
        if (!url.startsWith('assets/')) {
          image = errorChild;
        } else {
          image = ExtendedImage.asset(
            url,
            key: ValueKey(url),
            width: width,
            height: height,
            fit: fit,
            gaplessPlayback: true,
            shape: BoxShape.rectangle,
            borderRadius: borderRadius,
            mode: mode,
            enableSlideOutPage: enableSlideOutPage,
            initGestureConfigHandler: initGestureConfig,
            loadStateChanged: (state) => _buildLoadState(
              context: context,
              state: state,
              placeholder: placeholderChild,
              error: errorChild,
            ),
          );
        }
        break;
      case CustomImageType.network:
        if (!url.startsWith('http')) {
          image = errorChild;
        } else {
          image = ExtendedImage.network(
            url,
            key: ValueKey(url),
            width: width,
            height: height,
            fit: fit,
            shape: BoxShape.rectangle,
            borderRadius: borderRadius,
            mode: mode,
            gaplessPlayback: true,
            enableSlideOutPage: enableSlideOutPage,
            initGestureConfigHandler: initGestureConfig,
            loadStateChanged: (state) => _buildLoadState(
              context: context,
              state: state,
              placeholder: placeholderChild,
              error: errorChild,
            ),
          );
        }
        break;
      case CustomImageType.file:
        if (!url.startsWith('/')) {
          image = errorChild;
        } else {
          image = ExtendedImage.file(
            File(url),
            key: ValueKey(url),
            width: width,
            height: height,
            fit: fit,
            shape: BoxShape.rectangle,
            borderRadius: borderRadius,
            mode: mode,
            gaplessPlayback: true,
            enableSlideOutPage: enableSlideOutPage,
            initGestureConfigHandler: initGestureConfig,
            loadStateChanged: (state) => _buildLoadState(
              context: context,
              state: state,
              placeholder: placeholderChild,
              error: errorChild,
            ),
          );
        }
        break;
      case CustomImageType.base64:
        /*if (!url.startsWith('data:image') &&
            (placeholder != null || error != null)) {
          image = error ?? placeholder;
        } else {
          final base64 = url.split(',')[1];
          final bytes = const Base64Decoder().convert(base64);
          image = ExtendedImage.memory(
            bytes,
            width: width,
            height: height,
            fit: fit,
            shape: BoxShape.rectangle,
            borderRadius: borderRadius,
            mode: mode,
            gaplessPlayback: true,
            enableSlideOutPage: enableSlideOutPage,
            initGestureConfigHandler: initGestureConfig,
            loadStateChanged: (state) => _buildLoadState(context, state),
          );
        }*/
        break;
    }

    return Container(
      clipBehavior: Clip.hardEdge,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.tertiary,
        borderRadius: borderRadius,
      ),
      child: IconTheme(
        data: IconThemeData(
          size: 24,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
        child: image ?? const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildLoadState({
    required BuildContext context,
    required ExtendedImageState state,
    required Widget placeholder,
    required Widget error,
  }) {
    switch (state.extendedImageLoadState) {
      case LoadState.loading:
        return Center(child: placeholder);
      case LoadState.completed:
        Size? size;
        if (state.extendedImageInfo != null) {
          size = Size(
            state.extendedImageInfo!.image.width.toDouble(),
            state.extendedImageInfo!.image.height.toDouble(),
          );
        }
        final provider = state.imageProvider;
        final completed = state.completedWidget;
        return builder?.call(context, provider, completed, size) ?? completed;
      case LoadState.failed:
        return Center(child: error);
    }
  }
}
