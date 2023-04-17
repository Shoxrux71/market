import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:market/moduls/product.dart';
import 'package:market/providers/products.dart';
import 'edit_product_screen.dart';
import 'package:market/widgets/app_drawer.dart';

import '../widgets/user_product_item.dart';

class ManageProductsScreen extends StatelessWidget {
  const ManageProductsScreen({super.key});

  static const routeNamwe = '/manage-product';
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context).getProductsFromFireBase();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("control products"),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: ListView.builder(
            itemCount: productProvider.list.length,
            itemBuilder: (ctx, i) {
              final product = productProvider.list[i];
              return ChangeNotifierProvider.value(
                value: product,
                child: UserProductItem(),
              );
            }),
      ),
    );
  }
}
