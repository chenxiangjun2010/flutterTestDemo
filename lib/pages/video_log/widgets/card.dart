/// @Description:
/// @Author: 歪脖子
/// @Date: 2023-10-29 18:59

part of pages.video_log;

class BuildCard extends StatelessWidget {
  final String? projectName;
  final String? projectNum;
  final String? projectOutNum;
  final String? deviceID;

  final String? postTime;
  final String? user;
  final int? id;
  final bool? isBind;
  final int? videoDeviceSFID;
  final String? title;

  const BuildCard({
    super.key,
    this.projectName,
    this.projectNum,
    this.projectOutNum,
    this.deviceID,
    this.postTime,
    this.id,
    this.user,
    this.isBind,
    this.videoDeviceSFID,
    this.title,
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
                '${title ?? ''}',
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
          DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 14),
            child: Row(
              children: [
                // Text(
                //   dateTime ?? '',
                //   style: TextStyle(
                //     color: Theme.of(context).colorScheme.onSecondary,
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFE2EBFD),
                ),
                child: Text(
                  '内部编号：${projectNum ?? '-'}',
                  style: TextStyle(
                      fontSize: 12, color: Color(0xFF0A60D9), height: 1.5),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              DecoratedBox(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(27, 179, 128, 0.2)),
                child: Text(
                  '外部编号：${projectOutNum ?? '-'}',
                  style: TextStyle(
                      fontSize: 12, color: Color(0xFF1BB380), height: 1.5),
                ),
              ),
            ],
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
            '操作人：${user ?? '-'}',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          Text(
            '操作日期：${postTime ?? '-'}',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
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
    required this.crossAxisAlignment,
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
