part of widgets;

class CustomPullScrollView extends StatelessWidget {
  final EasyRefreshController controller;
  final bool refreshOnStart;
  final ERChildBuilder? builder;
  final void Function()? onRefresh;
  final void Function()? onLoading;

  const CustomPullScrollView({
    Key? key,
    required this.controller,
    this.refreshOnStart = true,
    this.onRefresh,
    this.onLoading,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.builder(
      header: const ClassicHeader(showText: false),
      footer: const ClassicFooter(showText: false),
      controller: controller,
      onRefresh: onRefresh,
      onLoad: onLoading,
      refreshOnStart: refreshOnStart,
      childBuilder: builder,
    );
  }
}
