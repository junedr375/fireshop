import 'package:fireshop/features/checkout/PLoC/cart_controller.dart';
import 'package:fireshop/features/home/PloC/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget {
  final HomeController homeController;
  final CartController cartController;
  const HomeAppBar(
      {Key? key, required this.homeController, required this.cartController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      forceElevated: true,
      floating: true,
      pinned: true,
      centerTitle: true,
      toolbarHeight: 40,
      expandedHeight: 100,
      backgroundColor: Colors.white,
      leading: IconButton(
          icon: const Icon(
            Icons.menu,
            size: 30,
          ),
          onPressed: homeController.openDrawer),
      actions: [
        Stack(
          children: [
            IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
                onPressed: homeController.onCartClick),
            Obx(
              () => Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    height: 18,
                    width: 18,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: Text('${cartController.currentCart.length}'),
                  )),
            ),
          ],
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () {
            final tableMenuList =
                homeController.resturant.value.tableMenuList ?? [];
            return homeController.isLoading.value
                ? const SizedBox()
                : TabBar(
                    isScrollable: true,
                    controller: homeController.tabController,
                    indicatorColor: Colors.red,
                    tabs: tableMenuList
                        .map(
                          (menu) => Text(menu.menuCategory ?? ''),
                        )
                        .toList(),
                  );
          },
        ),
      ),
    );
  }
}
