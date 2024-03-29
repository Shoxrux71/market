import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String describtion;
  final double price;
  final String imgUrl;
  bool isFavorite;

  Product({
    required this.describtion,
    required this.id,
    required this.imgUrl,
    required this.price,
    required this.title,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite() async {
    var oldFavorite = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final url = Uri.parse(
        'https://market-app-6ddb2-default-rtdb.firebaseio.com/proucts1/$id.json');
    try {
      final response = await http.patch(
        url,
        body: jsonEncode(
          {
            'isFavorite': isFavorite,
          },
        ),
      );

      if (response.statusCode >= 400) {
        isFavorite = oldFavorite;
        notifyListeners();
      }
    } catch (e) {
      isFavorite = oldFavorite;
      notifyListeners();
    }
  }
}
