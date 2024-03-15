/// @Description: 小徽章
/// @Author: 歪脖子
/// @Date: 2023-10-15 21:02

part of widgets;

class CustomBadge extends StatelessWidget {
  final int value;

  const CustomBadge({
    super.key,
    this.value = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (value <= 0) return const SizedBox.shrink();
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 3),
      constraints: const BoxConstraints(
        minWidth: 18,
        minHeight: 18,
      ),
      decoration: ShapeDecoration(
        color: colorScheme.primary,
        shape: const StadiumBorder(),
      ),
      child: Text(
        value.toString(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }
}
