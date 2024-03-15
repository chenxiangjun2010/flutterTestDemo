/// @Description:
/// @Author: 歪脖子
/// @Date: 2023-10-29 18:59

part of pages.video_admin;

class BuildCard extends StatelessWidget {
  final String? deviceName;
  final String? deviceUser;
  final String? userPhone;
  final String? projectName;
  final String? projectNum;
  final String? projectOutNum;
  final String? deviceID;
  final String? dateTime;
  final int? id;
  final int? sfid;
  final String? setting;

  const BuildCard({
    super.key,
    this.deviceName,
    this.deviceUser,
    this.userPhone,
    this.projectName,
    this.projectNum,
    this.projectOutNum,
    this.deviceID,
    this.dateTime,
    this.id,
    this.sfid,
    this.setting,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${deviceName ?? ''}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                '${deviceID}' ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF0A60D9),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Color(0xFFE2EBFD),
                      ),
                      child: Text(
                        '内部编号：${projectNum ?? '-'}',
                        style: const TextStyle(
                            fontSize: 12,
                            height: 1.5,
                            color: Color(0xFF0A60D9)),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(27, 179, 128, 0.2)),
                      child: Text(
                        '外部编号：${projectOutNum ?? '-'}',
                        style: const TextStyle(
                            fontSize: 12,
                            height: 1.5,
                            color: Color(0xFF1BB380)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '所属工程：',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              Text(
                projectName != '' ? projectName ?? '' : '未绑定',
                style: TextStyle(
                  fontSize: 14,
                  color: (projectName != '')
                      ? Theme.of(context).colorScheme.onSecondary
                      : AppTheme.error,
                ),
              ),
            ],
          ),
          Text(
            userPhone!.isEmpty
                ? '使用人：${deviceUser ?? '-'}'
                : '使用人：${deviceUser ?? '-'} (${userPhone ?? ''})',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          const SizedBox(height: 10),
          Divider(height: 0.5),
          const SizedBox(height: 10),
          // 操作按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (setting!.contains('log'))
                CustomButton(
                  shape: CustomButtonShape.radius,
                  // type: CustomButtonType.filled,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.margin, vertical: 4),
                  fontSize: 14,
                  onPressed: () {
                    context.pushNamed(Routes.videoLog,
                        queryParameters: {'id': sfid.toString()});
                  },
                  child: const Text(
                    '日志',
                  ),
                ),
              if (setting!.contains('log')) SizedBox(width: 10),
              if (setting!.contains('edit'))
                CustomButton(
                  shape: CustomButtonShape.radius,
                  type: CustomButtonType.filled,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.margin, vertical: 4),
                  fontSize: 14,
                  onPressed: () {
                    context.pushNamed(Routes.videoDetail, queryParameters: {
                      'id': id.toString(),
                    });
                  },
                  child: const Text(
                    '编辑',
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final String label;
  final String value;

  const _Item({
    Key? key,
    required this.label,
    required this.value,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'number',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Theme.of(context).colorScheme.onTertiary,
          ),
        ),
      ],
    );
  }
}
