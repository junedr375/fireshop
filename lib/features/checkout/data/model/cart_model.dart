import 'package:fireshop/features/home/data/models/resturant_model.dart';

class CartItem {
  CartItem({
    required this.categoryDish,
    required this.quantity,
  });
  CategoryDish categoryDish;
  int quantity;
}
