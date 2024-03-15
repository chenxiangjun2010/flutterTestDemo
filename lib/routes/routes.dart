part of routes;

abstract class Routes {
  static final RouteObserver<Route> observer = RouteObservers();
  static final List<String> history = [];

  static const main = 'main';
  static const login = 'login';
  static const videoLog = 'video_log';
  static const commodityDetail = 'commodity_detail';
  static const videoDetail = 'video_detail';
  static const projectBuildDetail = 'project_detail';
  static const settle = 'settle';
  static const goodsChoose = 'goods_choose';
  static const videoAdmin = 'video_admin';
  static const amap = 'amap';
  static const downLoad = 'downLoad';

  static const noAuthPaths = ['/$login'];

  static final GoRouter config = GoRouter(
    // debugLogDiagnostics: !kReleaseMode,
    initialLocation: '/',
    observers: [observer],
    redirect: _RouteRedirect.auth,
    routes: [
      GoRoute(
        path: '/',
        name: main,
        redirect: (context, state) => null,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const MainPage(),
        ),
      ),
      GoRoute(
        path: '/$login',
        name: login,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: '/$commodityDetail',
        name: commodityDetail,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: CommodityDetailPage(
            id: state.uri.queryParameters['id'],
          ),
        ),
      ),
      GoRoute(
        path: '/$videoDetail',
        name: videoDetail,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: VideoDetailPage(
            id: state.uri.queryParameters['id'],
          ),
        ),
      ),
      // 工程施工详情
      GoRoute(
        path: '/$projectBuildDetail',
        name: projectBuildDetail,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: ProjectBuildDetailPage(
            id: state.uri.queryParameters['id'],
            projectID: state.uri.queryParameters['projectID'],
          ),
        ),
      ),
      GoRoute(
        path: '/$videoAdmin',
        name: videoAdmin,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: const VideoAdminPage(),
        ),
      ),
      GoRoute(
        path: '/$videoLog',
        name: videoLog,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: VideoLogPage(
            id: state.uri.queryParameters['id'],
          ),
        ),
      ),
      GoRoute(
        path: '/$amap',
        name: amap,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: MapPage(
            id: state.uri.queryParameters['id'],
          ),
        ),
      ),
      GoRoute(
        path: '/$downLoad',
        name: downLoad,
        pageBuilder: (context, state) => CupertinoPage(
          name: state.uri.toString(),
          key: state.pageKey,
          child: MapPage(
            id: state.uri.queryParameters['id'],
          ),
        ),
      ),
    ],
  );
}

abstract class _RouteRedirect {
  static String? auth(BuildContext context, GoRouterState state) {
    if (UserStore.to.isLogin) return null;
    return '/${Routes.login}';
  }
}
