import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../moduls/product.dart';
import 'package:http/http.dart' as http;
import '../services/http_exception.dart';
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _list = [
    // Product(
    //   describtion:
    //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    //   id: 'p1',
    //   imgUrl:
    //       'https://images.unsplash.com/photo-1521383899078-1c7c03c76b59?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=793&q=80',
    //   price: 562,
    //   title: "Macbook",
    // ),
    // Product(
    //   describtion:
    //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    //   id: 'p2',
    //   imgUrl:
    //       'https://images.unsplash.com/photo-1591815302525-756a9bcc3425?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    //   price: 462,
    //   title: "Iphone",
    // ),
    // Product(
    //   describtion:
    //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    //   id: 'p3',
    //   imgUrl: 'https://i.insider.com/5dd2d2f27eece55b137c4a2c',
    //   price: 362,
    //   title: "Headphone",
    // ),
    // Product(
    //   describtion:
    //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    //   id: 'p4',
    //   imgUrl:
    //       'https://images.unsplash.com/photo-1609081219090-a6d81d3085bf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1026&q=80',
    //   price: 262,
    //   title: "Airpods",
    // ),
  ];

  // var _showOlnyFavorites = false;

  List<Product> get list {
    // if (_showOlnyFavorites) {
    //   return _list.where((product) => product.isFavorite).toList();
    // }
    return [..._list];
  }

  List<Product> get like {
    return _list.where((productt) => productt.isFavorite).toList();
  }

  List<Product> _cartItem = [];

  List<Product> get cartItem {
    return [..._cartItem];
  }

  void addToCart(Product product) {
    _cartItem.add(product);
  }

  // void showAll() {
  //   _showOlnyFavorites = false;
  //   notifyListeners();
  // }

  // void showLike() {
  //   _showOlnyFavorites = true;
  //   notifyListeners();
  // }

  Future<void> getProductsFromFireBase() async {
    final url = Uri.parse(
        'https://market-app-6ddb2-default-rtdb.firebaseio.com/proucts1.json');

    try {
      final response = await http.get(url);

      if (jsonDecode(response.body) != null) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List<Product> loadedProduct = [];
        data.forEach((productId, productData) {
          loadedProduct.add(
            Product(
              id: productId,
              describtion: productData["desc"].toString(),
              imgUrl: productData['imgUrl'],
              price: productData['price'],
              title: productData['title'],
              isFavorite: productData['isFavorite'],
            ),
          );
        });
        _list = loadedProduct;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) {
    // http formula = Http Endpoint (url) + http so'rovi = natija!
    final url = Uri.parse(
        'https://market-app-6ddb2-default-rtdb.firebaseio.com/proucts1.json');
    return http
        .post(
      url,
      body: jsonEncode(
        {
          'title': product.title,
          'describtion': product.describtion,
          'imgUrl': product.imgUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        },
      ),
    )
        .then((response) {
      final nameId =
          (jsonDecode(response.body) as Map<String, dynamic>)['name'];
      // .print(response.body); shu joyda 1kun qotb qoldm!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!09.04.2023
      final newProduct = Product(
          describtion: product.describtion,
          id: nameId,
          imgUrl: product.imgUrl,
          price: product.price,
          title: product.title);
      _list.add(newProduct);
      notifyListeners();
    }).catchError((error) {
      print(error);
      throw error;
    });
    // http sorov
    // _list.add(value);
  }

  Future<void> updatedProduct(Product updatedProduct) async {
    final productIndex =
        _list.indexWhere((product) => product.id == updatedProduct.id);
    // print(productIndex);
    if (productIndex >= 0) {
      final url = Uri.parse(
          'https://market-app-6ddb2-default-rtdb.firebaseio.com/proucts1/${updatedProduct.id}.json');
      try {
        await http.patch(
          url,
          body: jsonEncode(
            {
              'title': updatedProduct.title,
              'describtion': updatedProduct.describtion,
              'price': updatedProduct.price,
              'imgUrl': updatedProduct.imgUrl,
            },
          ),
        );
        _list[productIndex] = updatedProduct;
        notifyListeners();
      } catch (e) {
        rethrow;
      }
      ;
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://market-app-6ddb2-default-rtdb.firebaseio.com/proucts1/$id.json');

    try {
      var deletingProduct = _list.firstWhere((product) => product.id == id);
      final productIndex = _list.indexWhere((product) => product.id == id);
      _list.removeWhere((product) => product.id == id);
      notifyListeners();

      final response = await http.delete(url);
      if (response.statusCode >= 400) {
        _list.insert(productIndex, deletingProduct);
        notifyListeners();
        throw HttpException('error delete product!');
      }
    } catch (e) {
      rethrow;
    }
  }

  Product findById(String productId) {
    return list.firstWhere((product) => product.id == productId);
  }
}
