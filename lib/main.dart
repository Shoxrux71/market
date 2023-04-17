import 'package:flutter/material.dart';
import 'package:market/moduls/cart_item.dart';
import 'package:market/providers/cart.dart';
import 'package:market/providers/orders.dart';
import 'package:market/providers/products.dart';
import 'package:market/screens/manage_product_screen.dart';
import 'package:market/screens/orders_screen.dart';
import 'package:market/screens/product_screens_detail.dart';
import './screens/home_screen.dart';
import './style/my_shop_style.dart';
import 'package:provider/provider.dart';
import './screens/cart_screen.dart';
import './screens/edit_product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  ThemeData theme = MyShopStyle.style;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(
          create: (ctx) {
            return Products();
          },
        ),
        ChangeNotifierProvider<Cart>(
          create: (ctx) {
            return Cart();
          },
        ),
        ChangeNotifierProvider<Orders>(
          create: (ctx) {
            return Orders();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme,
        initialRoute: HomeScreen.routeName,
        routes: {
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          ProductDetailsScreen.routeNamed: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          ManageProductsScreen.routeNamwe: (ctx) => ManageProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
// Provider.of orniga consumerdan foydalanish qismiga keldim
// 05.03.23-Savatcha sahifasini ko'rsatish va umumiy miqdorni ko'rsatish
// 19.03.2023 Mahsulot haqida batafsil sahifani yaratish
// 8-1 qismi tugadi
// 8-3 mahsulotlarni boshqarish sahifasini yaratishni boshlimann,hali kechki payt
// 8-5 Form va TextFormField widjetlar farqi
// 8-rasm urlni oliw va uni korsatiwga keldm 

