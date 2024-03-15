part of pages.main;

class MainController extends GetxController {
  final PageController pageController = PageController();

  int currentPage = 0;

  void onPageChanged(int page) {
    currentPage = page;
    update(['navigation']);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
