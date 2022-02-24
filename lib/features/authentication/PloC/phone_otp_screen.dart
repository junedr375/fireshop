import 'package:fireshop/core/utils/app_theme_data.dart';
import 'package:fireshop/core/utils/get_of_context.dart';
import 'package:fireshop/features/authentication/PloC/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PhoneOtpScreen extends StatelessWidget {
  PhoneOtpScreen({Key? key}) : super(key: key);

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final height = getMainAxisHeight(context);
    final screenWidth = getMediaQuerySize(context).width;
    final theme = getThemeData(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Signin with Phone',
          style: theme.textTheme.headline2?.copyWith(color: Colors.black),
        ),
      ),
      body: Form(
        key: authController.formGlobalKey,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: TextFormField(
                controller: authController.phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) => value?.length != 10
                    ? 'Invalid Number enter 10 digit number'
                    : null,
                maxLength: 10,
                decoration: const InputDecoration(
                    border: InputBorder.none, labelText: 'Enter Phone Number'),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Obx(
              () => Visibility(
                visible: authController.isOtpSent.value,
                child: TextFormField(
                  controller: authController.otpController,
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value?.length != 6 ? 'Enter 6 digit OTP' : null,
                  maxLength: 6,
                  decoration: const InputDecoration(
                      border: InputBorder.none, labelText: 'Enter OTP'),
                ).paddingSymmetric(vertical: 20, horizontal: 10),
              ),
            ),
            Obx(
              () => GestureDetector(
                onTap: authController.doSigninWithPhone,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  height: 50,
                  width: screenWidth * 0.9,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.green[900]),
                  child: Text(
                    authController.isOtpSent.value ? 'Verify' : 'Send OTP',
                    style: theme.textTheme.headline3
                        ?.copyWith(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
