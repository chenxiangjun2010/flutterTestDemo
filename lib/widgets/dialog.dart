part of widgets;

class CustomDialog extends StatelessWidget {
  final Widget child;
  final Widget? title;
  final Widget? cancel;
  final Widget? confirm;
  final void Function()? onCancel;
  final void Function()? onConfirm;

  const CustomDialog({
    Key? key,
    required this.child,
    this.title,
    this.cancel,
    this.confirm,
    this.onCancel,
    this.onConfirm,
  }) : super(key: key);

  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    Widget? title,
    Widget? confirm,
    Widget? cancel,
    void Function()? onConfirm,
    void Function()? onCancel,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => CustomDialog(
        title: title,
        confirm: confirm,
        cancel: cancel,
        onConfirm: onConfirm,
        onCancel: onCancel,
        child: builder(context),
      ),
    );
  }

  static Future<void> showAccess({
    required BuildContext context,
    required Widget content,
  }) async {
    await show(
      context: context,
      builder: (context) => content,
      title: const Text('请求权限'),
      cancel: const Text('取消'),
      confirm: const Text('去设置'),
      onCancel: () => Navigator.of(context).pop(),
      onConfirm: () => Access.setting(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonGroup = <Widget>[];
    if (cancel != null) {
      buttonGroup.add(Expanded(
        child: CustomButton(
          shape: CustomButtonShape.stadium,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          onPressed: onCancel,
          child: cancel!,
        ),
      ));
    }
    if (confirm != null && cancel != null) {
      buttonGroup.add(const SizedBox(width: 12));
    }
    if (confirm != null) {
      buttonGroup.add(Expanded(
        child: CustomButton(
          shape: CustomButtonShape.stadium,
          type: CustomButtonType.filled,
          onPressed: onConfirm,
          child: confirm!,
        ),
      ));
    }
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.all(AppTheme.margin),
              child: DefaultTextStyle.merge(
                textAlign: TextAlign.center,
                style: DialogTheme.of(context).titleTextStyle,
                child: title!,
              ),
            ),
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(AppTheme.margin).copyWith(
                top: title != null ? 0 : null,
                bottom: buttonGroup.isNotEmpty ? 0 : null,
              ),
              child: DefaultTextStyle.merge(
                textAlign: TextAlign.center,
                style: DialogTheme.of(context).contentTextStyle?.copyWith(
                      fontSize: title != null ? 18 : null,
                    ),
                child: Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(minHeight: 80),
                  child: child,
                ),
              ),
            ),
          ),
          if (buttonGroup.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(AppTheme.margin),
              child: Row(children: buttonGroup),
            ),
        ],
      ),
    );
  }
}
