import 'package:flutter/material.dart';
import '../moduls/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int itemsCount() {
    return _items.length;
  }

  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addToCart(
    String productId,
    String title,
    String img,
    double price,
  ) {
    if (_items.containsKey(productId)) {
      // add quantity
      _items.update(
        productId,
        (currentProduct) => CartItem(
            id: currentProduct.id,
            img: currentProduct.img,
            price: currentProduct.price,
            quantity: currentProduct.quantity + 1,
            title: currentProduct.title),
      );
    } else {
      // new product added to busket
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: UniqueKey().toString(),
            img: img,
            price: price,
            quantity: 1,
            title: title),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String productId, {bool isCartButton = false}) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (currentProduct) => CartItem(
            id: currentProduct.id,
            img: currentProduct.img,
            price: currentProduct.price,
            quantity: currentProduct.quantity - 1,
            title: currentProduct.title),
      );
    } else if (isCartButton) {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
