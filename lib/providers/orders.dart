import 'package:flutter/material.dart';
import '../moduls/order.dart';
import '../moduls/cart_item.dart';

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  void addToOrders(List<CartItem> products, double totalPrice) {
    _items.insert(
      0,
      Order(
          id: UniqueKey().toString(),
          date: DateTime.now(),
          products: products,
          totalPrice: totalPrice),
    );
    notifyListeners();
  }
}
