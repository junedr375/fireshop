import 'package:fireshop/core/utils/app_theme_data.dart';
import 'package:fireshop/core/utils/get_of_context.dart';
import 'package:fireshop/features/checkout/PLoC/cart_controller.dart';
import 'package:fireshop/features/home/PloC/components/home_appbar.dart';
import 'package:fireshop/features/home/PloC/components/home_drawer.dart';
import 'package:fireshop/features/home/PloC/components/items.dart';
import 'package:fireshop/features/home/PloC/home_controller.dart';
import 'package:fireshop/features/home/data/models/resturant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    Size screenSize = getMediaQuerySize(context);
    double mainAxisHeight = getMainAxisHeight(context);
    final theme = getThemeData(context);
    return Scaffold(
      key: homeController.scaffoldKey,
      backgroundColor: Colors.white,
      drawer: HomeDrawer(homeController: homeController),
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            HomeAppBar(
              homeController: homeController,
              cartController: cartController,
            ),
          ];
        },
        body: Obx(
          () {
            final tableMenuList =
                homeController.resturant.value.tableMenuList ?? [];
            return homeController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : TabBarView(
                    controller: homeController.tabController,
                    children: tableMenuList
                        .map(
                          (menu) => TableMenuListWidget(
                            menuList: menu,
                            homeController: homeController,
                            cartController: cartController,
                          ),
                        )
                        .toList(),
                  );
          },
        ),
      ),
    );
  }
}

class TableMenuListWidget extends StatelessWidget {
  final TableMenuList menuList;
  final HomeController homeController;
  final CartController cartController;
  const TableMenuListWidget(
      {Key? key,
      required this.menuList,
      required this.homeController,
      required this.cartController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return FoodItem(
            food: menuList.categoryDishes?[index] ?? CategoryDish(),
            homeController: homeController,
            cartController: cartController,
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 1, thickness: 1, color: Colors.grey[500]);
        },
        itemCount: menuList.categoryDishes?.length ?? 0);
  }
}
