import 'package:flutter/material.dart';
import '../moduls/product.dart';

class Products with ChangeNotifier {
  List<Product> _list = [
    Product(
      describtion:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      id: 'p1',
      imgUrl: 'https://i.ytimg.com/vi/Km4jrOfGCjg/maxresdefault.jpg',
      price: 562,
      title: "Macbook",
    ),
    Product(
      describtion:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      id: 'p2',
      imgUrl: 'https://www.superplanshet.ru/images/iPhone_14_G188R.jpg',
      price: 462,
      title: "Iphone",
    ),
    Product(
      describtion:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      id: 'p3',
      imgUrl: 'https://i.insider.com/5dd2d2f27eece55b137c4a2c',
      price: 362,
      title: "Headphone",
    ),
    Product(
      describtion:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
      id: 'p4',
      imgUrl:
          'https://akket.com/wp-content/uploads/2019/04/AirPods-3-Apple-0.jpg',
      price: 262,
      title: "Airpods",
    ),
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

  void addProduct(Product product) {
    // _list.add(value);
    final newProduct = Product(
        describtion: product.describtion,
        id: UniqueKey().toString(),
        imgUrl: product.imgUrl,
        price: product.price,
        title: product.title);
    _list.insert(0, newProduct);
    notifyListeners();
  }

  void updatedProduct(Product updatedProduct) {
    final productIndex =
        _list.indexWhere((product) => product.id == updatedProduct.id);
    // print(productIndex);
    if (productIndex >= 0) {
      _list[productIndex] = updatedProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _list.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  Product findById(String productId) {
    return list.firstWhere((product) => product.id == productId);
  }
}
