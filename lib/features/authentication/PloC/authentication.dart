import 'package:fireshop/core/UI/image.dart';
import 'package:fireshop/core/utils/app_theme_data.dart';
import 'package:fireshop/core/utils/get_of_context.dart';
import 'package:fireshop/features/authentication/PloC/authentication_controller.dart';
import 'package:fireshop/features/checkout/PLoC/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationScreen extends StatelessWidget {
  AuthenticationScreen({Key? key}) : super(key: key);

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final height = getMainAxisHeight(context);
    return Scaffold(
      body: Obx(
        () => authController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height * 0.25,
            alignment: Alignment.center,
            child: Image.asset(
              Images.firebaseLogo,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: height * 0.35,
          ),
          AuthButton(
            onTap: () {
              authController.doGoggleSignIn(context);
            },
            text: 'Google',
            color: Colors.blue,
            leading: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              height: 30,
              width: 30,
              child: Image.asset(
                Images.googleIcon,
                height: 20,
                width: 20,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
      
        ],
              ),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Widget leading;
  final Color color;
  const AuthButton(
      {Key? key,
      required this.onTap,
      required this.text,
      required this.leading,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = getThemeData(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(colors: [color.withOpacity(0.9), color])),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            leading,
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style:
                      theme.textTheme.headline3?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
