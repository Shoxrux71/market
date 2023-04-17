import 'package:flutter/material.dart';

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

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
