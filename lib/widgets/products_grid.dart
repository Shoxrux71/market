import 'package:flutter/material.dart';
import 'package:market/moduls/product.dart';
import 'package:market/providers/products.dart';
import 'package:provider/provider.dart';
import './product_item.dart';
import '../moduls/product.dart';

class ProductsGrid extends StatelessWidget {
  final bool liked;
  const ProductsGrid(
    this.liked, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ==========================
    final productData = Provider.of<Products>(context);
    final product = liked ? productData.like : productData.list;
    // ==========================

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemCount: product.length,
      itemBuilder: (ctx, i) {
        return ChangeNotifierProvider<Product>.value(
          value: product[i],
          child: const ProductItem(
              // img: product[i].imgUrl,
              // titlee: product[i].title,
              // productId: product[i].id,
              ),
        );
      },
    );
  }
}
