import 'package:fireshop/core/utils/app_theme_data.dart';
import 'package:fireshop/core/utils/get_of_context.dart';
import 'package:fireshop/features/home/PloC/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDrawer extends StatelessWidget {
  final HomeController homeController;
  const HomeDrawer({Key? key, required this.homeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = getMediaQuerySize(context);
    final theme = getThemeData(context);
    return Container(
      height: screenSize.height,
      width: screenSize.width * 0.85,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: screenSize.height * 0.35,
            width: screenSize.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.green[500],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: homeController.currentUser?.photoURL != null,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      homeController.currentUser?.photoURL ?? '',
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: homeController.currentUser?.displayName != null,
                  child: Text(
                    homeController.currentUser?.displayName ?? '',
                    style: theme.textTheme.headline3,
                  ),
                ),
                Text(
                  'ID: ${homeController.currentUser?.uid ?? ''}',
                  style: theme.textTheme.headline3,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: homeController.onLogout,
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  size: 40,
                  color: Colors.grey[600],
                ),
                const SizedBox(
                  width: 25,
                ),
                Text(
                  'Log out',
                  style: theme.textTheme.headline3
                      ?.copyWith(color: Colors.grey[600]),
                )
              ],
            ),
          ).paddingSymmetric(horizontal: 10, vertical: 20),
        ],
      ),
    );
  }
}
