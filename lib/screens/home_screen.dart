import 'package:flutter/material.dart';
import 'package:market/providers/cart.dart';
import 'package:market/providers/products.dart';
import 'package:provider/provider.dart';
import '../moduls/product.dart';
import '../widgets/product_item.dart';
import '../widgets/products_grid.dart';
import '../widgets/custom_cart.dart';
import 'cart_screen.dart';
import '../widgets/app_drawer.dart';

enum FilterOption { All, Like }

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _showOnlyLike = false;

  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<Products>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Online Shop"),
        actions: [
          PopupMenuButton(onSelected: (FilterOption filter) {
            setState(() {
              if (filter == FilterOption.All) {
                // show all
                // productData.showAll();
                _showOnlyLike = false;
              } else {
                // show like
                // productData.showLike();
                _showOnlyLike = true;
              }
            });
          }, itemBuilder: (ctx) {
            return [
              const PopupMenuItem(
                value: FilterOption.All,
                child: Text("All"),
              ),
              const PopupMenuItem(
                value: FilterOption.Like,
                child: Text("Like"),
              ),
            ];
          }),
          Consumer<Cart>(
            builder: (ctx, child, cartCount) {
              return CustomCart(
                iconChild: cartCount!,
                number: cart.itemsCount().toString(),
              );
            },
            child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
              icon: const Icon(Icons.add_shopping_cart_outlined),
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(
        _showOnlyLike,
      ),
    );
  }
}
