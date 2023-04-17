import 'package:flutter/material.dart';
import 'package:market/providers/cart.dart';
import 'package:market/providers/products.dart';
import 'package:market/screens/cart_screen.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({
    super.key,
  });

  static const routeNamed = 'details-product';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments;
    final product = Provider.of<Products>(context, listen: false)
        .findById(productId as String);
    print(productId);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                product.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.title,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.describtion,
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Container(
          height: 75,
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price: ${product.title}',
                    style: TextStyle(
                        fontSize: 16, color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    '\$${product.price}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Consumer<Cart>(
                builder: (ctx, cart, child) {
                  final isProductAdded = cart.items.containsKey(productId);
                  if (isProductAdded) {
                    return ElevatedButton.icon(
                      onPressed: () =>
                          Navigator.of(context).pushNamed(CartScreen.routeName),
                      icon: Icon(
                        Icons.shopping_bag,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(
                        'go to bustek',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey.shade400),
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () => cart.addToCart(productId, product.title,
                          product.imgUrl, product.price),
                      child: Text('add to bustek'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
