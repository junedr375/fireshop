import 'package:fireshop/core/utils/app_theme_data.dart';
import 'package:fireshop/features/checkout/PLoC/cart_controller.dart';
import 'package:fireshop/features/home/data/models/resturant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemModifier extends StatelessWidget {
  final CategoryDish food;
  final CartController cartController;
  final Color? backGroungColor;
  const ItemModifier(
      {Key? key,
      required this.food,
      required this.cartController,
      this.backGroungColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.grey, offset: Offset(2, 2), blurRadius: 2)
          ],
          color: backGroungColor ?? Colors.green[400]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ItemIconButton(
            iconData: Icons.remove,
            onPresses: () {
              cartController.removeItemFromCart(food);
            },
          ),
          _ItemQuantity(food: food, cartController: cartController),
          ItemIconButton(
            iconData: Icons.add,
            onPresses: () {
              cartController.addItemToCart(food);
            },
          ),
        ],
      ),
    );
  }
}

class ItemIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPresses;
  const ItemIconButton(
      {Key? key, required this.iconData, required this.onPresses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPresses,
      icon: Icon(
        iconData,
        color: Colors.white,
      ),
    );
  }
}

class _ItemQuantity extends StatelessWidget {
  final CategoryDish food;
  final CartController cartController;
  const _ItemQuantity(
      {Key? key, required this.food, required this.cartController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = getThemeData(context);
    return Obx(() => Text(
          cartController.currentCart.contains(food)
              ? cartController
                  .currentCart[cartController.currentCart.indexOf(food)]
                  .itemsOnCart
                  .toString()
              : '0',
          style: theme.textTheme.headline2?.copyWith(color: Colors.white),
        ));
  }
}
