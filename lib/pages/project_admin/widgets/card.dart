/// @Description:
/// @Author: 歪脖子
/// @Date: 2023-10-29 18:59

part of pages.project_admin;

class BuildCard extends StatelessWidget {
  final String? startDate;
  final String? endDate;
  final String? bStateName;
  final String? bStatusName;
  final String? placeName;
  final String? statusName;
  final String? stateName;

  final String? deviceUser;
  final String? userPhone;
  final int? projectID;
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
    this.startDate,
    this.endDate,
    this.bStateName,
    this.bStatusName,
    this.placeName,
    this.statusName,
    this.stateName,
    this.deviceUser,
    this.userPhone,
    this.projectName,
    this.projectID,
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
    final colorScheme = Theme.of(context).colorScheme;
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  projectName ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                // suoshu
                Text(
                  '工程属地：$placeName' ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF0A60D9),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
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
                      fontSize: 12, height: 1.5, color: Color(0xFF0A60D9)),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              DecoratedBox(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(27, 179, 128, 0.2)),
                child: Text(
                  '外部编号：${projectOutNum ?? '-'}',
                  style: const TextStyle(
                      fontSize: 12, height: 1.5, color: Color(0xFF1BB380)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 14, color: Color(0XFF7D93B3)),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4)
                  .copyWith(top: 16),
              decoration: const BoxDecoration(color: Color(0xFFF0F4FA)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text('开工时间'),
                      Text(
                        '${startDate?.split(" ")[0] == "1900-01-01" ? '-' : startDate?.split(" ")[0]}',
                        style: const TextStyle(color: Color(0xFF324E76)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('完工时间'),
                      Text(
                        '${endDate?.split(" ")[0] == "1900-01-01" ? '-' : endDate?.split(" ")[0]}',
                        style: const TextStyle(color: Color(0xFF324E76)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('视频设备'),
                      Text(
                        deviceID ?? '-',
                        style: const TextStyle(color: Color(0xFF324E76)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          // const SizedBox(height: 10),
          DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 14, color: Color(0XFF7D93B3)),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4)
                  .copyWith(bottom: 16),
              decoration: const BoxDecoration(color: Color(0xFFF0F4FA)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text('施工状态'),
                      Text(
                        bStatusName ?? '-',
                        style: const TextStyle(color: Color(0xFF324E76)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('停水状态'),
                      Text(
                        bStateName ?? '-',
                        style: const TextStyle(color: Color(0xFF324E76)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('退回状态'),
                      Text(
                        stateName ?? '-',
                        style: const TextStyle(color: Color(0xFF324E76)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // 操作按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                shape: CustomButtonShape.radius,
                type: CustomButtonType.filled,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.margin, vertical: 8),
                fontSize: 14,
                onPressed: () {
                  print('2,$id');

                  context.pushNamed(Routes.amap, queryParameters: {
                    'id': id.toString(),
                  });
                },
                child: const Text(
                  '下载测试',
                ),
              ),
              CustomButton(
                shape: CustomButtonShape.radius,
                type: CustomButtonType.filled,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.margin, vertical: 8),
                fontSize: 14,
                onPressed: () {
                  print('1,$id');

                  context.pushNamed(Routes.amap, queryParameters: {
                    'id': id.toString(),
                  });
                },
                child: const Text(
                  '地图测试1',
                ),
              ),
              if (setting!.contains('edit'))
                CustomButton(
                  shape: CustomButtonShape.radius,
                  type: CustomButtonType.filled,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.margin, vertical: 8),
                  fontSize: 14,
                  onPressed: () {
                    context
                        .pushNamed(Routes.projectBuildDetail, queryParameters: {
                      'id': id.toString(),
                      'projectID': projectID.toString(),
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
    final colorScheme = Theme.of(context).colorScheme;
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
            color: colorScheme.onTertiary,
          ),
        ),
      ],
    );
  }
}
