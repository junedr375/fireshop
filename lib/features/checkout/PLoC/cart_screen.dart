import 'package:fireshop/core/utils/app_theme_data.dart';
import 'package:fireshop/core/utils/get_of_context.dart';
import 'package:fireshop/features/checkout/PLoC/cart_controller.dart';
import 'package:fireshop/features/checkout/PLoC/components/cart_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    final theme = getThemeData(context);
    final screenHeight = getMainAxisHeight(context);
    final screenWidth = getMediaQuerySize(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Order Summary',
          style: theme.textTheme.headline3,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.75,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2, 2),
                        blurRadius: 10),
                  ]),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green[900]),
                    alignment: Alignment.center,
                    child: Obx(
                      () => Text(
                        ' ${cartController.currentCart.length} Dishes - ${cartController.totalItems.value} Items',
                        style: theme.textTheme.headline4
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CartItemsWidget(
                                food: cartController.currentCart[index],
                                cartController: cartController);
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 0.5,
                              height: 0.5,
                              color: Colors.grey[500],
                            ).paddingSymmetric(horizontal: 2);
                          },
                          itemCount: cartController.currentCart.length),
                    ),
                  ),
                  Divider(
                    thickness: 0.8,
                    height: 0.8,
                    color: Colors.grey[600],
                  ).paddingSymmetric(horizontal: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount',
                        style: theme.textTheme.headline3
                            ?.copyWith(color: Colors.indigo[800]),
                      ),
                      Obx(
                        () => Text(
                          'INR ${cartController.totalPrice.value}',
                          style: theme.textTheme.headline3
                              ?.copyWith(color: Colors.green),
                        ),
                      ),
                    ],
                  ).paddingSymmetric(vertical: 20, horizontal: 12)
                ],
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: cartController.placeOrder,
            child: Container(
              height: 50,
              width: screenWidth * 0.9,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.green[900]),
              child: Text(
                'Place Order',
                style:
                    theme.textTheme.headline3?.copyWith(color: Colors.white70),
              ),
            ),
          )
        ],
      ).paddingAll(16),
    );
  }
}
