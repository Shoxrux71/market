import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../moduls/order.dart';
import '../moduls/cart_item.dart';

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  Future<void> getOrdersFromFirebase() async {
    final url = Uri.parse(
        'https://market-app-6ddb2-default-rtdb.firebaseio.com/orders1.json');

    try {
      final response = await http.get(url);
      if (jsonDecode(response.body) == null) {
        return;
      }
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      List<Order> loadedOrders = [];
      data.forEach(
        (orderId, order) {
          loadedOrders.insert(
            0,
            Order(
              id: orderId,
              totalPrice: order['totalPrice'],
              date: DateTime.parse(order['date']),
              products: (order['products'] as List<dynamic>)
                  .map(
                    (product) => CartItem(
                      id: product['id'],
                      img: product['img'],
                      price: product['price'],
                      quantity: product['quantity'],
                      title: product['title'],
                    ),
                  )
                  .toList(),
            ),
          );
        },
      );
      _items = loadedOrders;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addToOrders(List<CartItem> products, double totalPrice) async {
    final url = Uri.parse(
        'https://market-app-6ddb2-default-rtdb.firebaseio.com/orders1.json');
    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'totalPrice': totalPrice,
            'date': DateTime.now().toIso8601String(),
            'products': products
                .map(
                  (product) => {
                    'id': product.id,
                    'title': product.title,
                    'quantity': product.quantity,
                    'price': product.price,
                    'img': product.img,
                  },
                )
                .toList(),
          },
        ),
      );
      _items.insert(
        0,
        Order(
            id: jsonDecode(response.body)['name'],
            date: DateTime.now(),
            products: products,
            totalPrice: totalPrice),
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
