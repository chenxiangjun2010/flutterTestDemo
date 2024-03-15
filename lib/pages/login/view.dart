part of pages.login;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) => GestureDetector(
        onTap: () => Tools.unfocus(),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                // Color.fromRGBO(28, 56, 253, 1),
                Color(0xFF3155FA),
                Color.fromRGBO(78, 126, 246, 1),
                Color.fromRGBO(180, 218, 250, 1),
                Color.fromRGBO(242, 242, 242, 1)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp,
            )),
            child: SafeArea(
              minimum: const EdgeInsets.all(AppTheme.margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '清源水务项目管理平台',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 60),
                  TextField(
                    controller: controller.phoneInput,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(hintText: '手机号码'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller.passwordInput,
                    obscureText: true,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(hintText: '密码'),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    shape: CustomButtonShape.radius,
                    type: CustomButtonType.filled,
                    onPressed: () {
                      Tools.unfocus();
                      controller.submit(context);
                    },
                    child: const Text('登录'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
