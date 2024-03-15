part of pages.amap;

class MapPage extends StatefulWidget {
  final String? id;
  const MapPage({super.key, this.id});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Map<String, Object> _locationResult = {};

  late StreamSubscription<Map<String, Object>> _locationListener;

  final AMapFlutterLocation _locationPlugin = AMapFlutterLocation();

  // static const AMapApiKey amapApiKeys = AMapApiKey(
  //     androidKey: '914e144f7d57658cb549e23e5623bced',
  //     iosKey: '73c6f946d1839cec29d52d7a5ed65a68');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ///// [hasShow] 隐私权政策是否弹窗展示告知用户
    AMapFlutterLocation.updatePrivacyShow(true, true);

    /// [hasAgree] 隐私权政策是否已经取得用户同意
    AMapFlutterLocation.updatePrivacyAgree(true);

    /// 动态申请定位权限
    requestPermission();

    AMapFlutterLocation.setApiKey(
        "ccc8e438a81950ba87c11c2c4edbfb45", "73c6f946d1839cec29d52d7a5ed65a68");
    // "914e144f7d57658cb549e23e5623bced", "73c6f946d1839cec29d52d7a5ed65a68");

    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      print('Platform.isIOS');

      requestAccuracyAuthorization();
    }

    ///注册定位结果监听
    _locationListener = _locationPlugin
        .onLocationChanged()
        .listen((Map<String, Object> result) {
      print('result,$result');
      setState(() {
        _locationResult = result;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    ///移除定位监听
    _locationListener.cancel();

    ///销毁定位
    _locationPlugin.destroy();
  }

  ///设置定位参数
  void _setLocationOption() {
    AMapLocationOption locationOption = AMapLocationOption();

    ///是否单次定位
    locationOption.onceLocation = false;

    ///是否需要返回逆地理信息
    locationOption.needAddress = true;

    ///逆地理信息的语言类型
    locationOption.geoLanguage = GeoLanguage.DEFAULT;

    locationOption.desiredLocationAccuracyAuthorizationMode =
        AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

    locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

    ///设置Android端连续定位的定位间隔
    locationOption.locationInterval = 2000;

    ///设置Android端的定位模式<br>
    ///可选值：<br>
    ///<li>[AMapLocationMode.Battery_Saving]</li>
    ///<li>[AMapLocationMode.Device_Sensors]</li>
    ///<li>[AMapLocationMode.Hight_Accuracy]</li>
    locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

    ///设置iOS端的定位最小更新距离<br>
    locationOption.distanceFilter = -1;

    ///设置iOS端期望的定位精度
    /// 可选值：<br>
    /// <li>[DesiredAccuracy.Best] 最高精度</li>
    /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
    /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
    /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
    /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
    locationOption.desiredAccuracy = DesiredAccuracy.Best;

    ///设置iOS端是否允许系统暂停定位
    locationOption.pausesLocationUpdatesAutomatically = false;

    ///将定位参数设置给定位插件
    _locationPlugin.setLocationOption(locationOption);
  }

  ///开始定位
  void _startLocation() {
    ///开始定位之前设置定位参数
    _setLocationOption();
    _locationPlugin.startLocation();
  }

  ///停止定位
  void _stopLocation() {
    _locationPlugin.stopLocation();
  }

  ///在创建地图时设置apiKey属性
  // AMapWidget map = const AMapWidget(
  //   ///配置apiKey,设置为null或者不设置则优先使用native端配置的key
  //   apiKey: amapApiKeys,
  // );

  Container _createButtonContainer() {
    return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _startLocation,
              child: const Text('开始定位'),
            ),
            Container(width: 20.0),
            ElevatedButton(
              onPressed: _stopLocation,
              child: const Text('停止定位'),
            )
          ],
        ));
  }

  Widget _resultWidget(key, value) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            width: 100.0,
            child: Text('$key :'),
          ),
          Container(width: 5.0),
          Flexible(child: Text('$value', softWrap: true)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    widgets.add(_createButtonContainer());

    _locationResult.forEach((key, value) {
      widgets.add(_resultWidget(key, value));
    });

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('AMap Location plugin example app'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      ),
    ));
  }

  ///获取iOS native的accuracyAuthorization类型
  void requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization =
        await _locationPlugin.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      print("精确定位类型");
    } else if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      print("模糊定位类型");
    } else {
      print("未知定位类型");
    }
  }

  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      print("定位权限申请通过");
    } else {
      print("定位权限申请不通过");
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
