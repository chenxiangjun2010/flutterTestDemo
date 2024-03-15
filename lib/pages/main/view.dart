part of pages.main;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _connectPrinter();
    // });
    super.initState();
  }

  // void _connectPrinter() async {
  //   final result = await Access.bluetooth();
  //   if (!result) return;
  //   PrinterService.to.connect();
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) => const CustomResponsiveLayout(
        mobile: MainForMobile(),
        tablet: MainForTablet(),
      ),
    );
  }
}
