import 'package:flutter/material.dart';
import 'package:market/moduls/product.dart';
import 'package:market/providers/cart.dart';
import 'package:provider/provider.dart';
import '../screens/product_screens_detail.dart';

class ProductItem extends StatelessWidget {
  // final String productId;
  // final String img;
  // final String titlee;
  const ProductItem({
    super.key,
    // required this.img,
    // required this.titlee,
    // required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    print(cart.items);
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeNamed,
                arguments: product.id);
          },
          child: Image.network(
            product.imgUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, productData, child) {
              return IconButton(
                onPressed: () {
                  productData.toggleFavorite();
                },
                icon: Icon(
                  productData.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_outline,
                ),
                color: Theme.of(context).primaryColor,
              );
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addToCart(
                product.id,
                product.title,
                product.imgUrl,
                product.price,
              );
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              ScaffoldMessenger.of(context).showMaterialBanner(
                MaterialBanner(
                  content: const Text('added to buset'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          cart.removeSingleItem(product.id, isCartButton: true);
                          ScaffoldMessenger.of(context)
                              .hideCurrentMaterialBanner();
                        },
                        child: Text(
                          'cancel',
                          style: TextStyle(color: Theme.of(context).errorColor),
                        ))
                  ],
                ),
              );
              Future.delayed(const Duration(seconds: 4)).then((value) => 
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
              // ScaffoldMessenger.of(context).hideCurrentSnackBar();
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(
              //       'added to busket',
              //       style: TextStyle(color: Theme.of(context).primaryColor),
              //     ),
              //     duration: Duration(seconds: 2),
              //     action: SnackBarAction(
              //         label: 'cancel',
              //         onPressed: () {
              //           cart.removeSingleItem(product.id, isCartButton: true);
              //         }),
              //   ),
              // );
            },
            icon: Icon(Icons.add_shopping_cart_outlined),
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
