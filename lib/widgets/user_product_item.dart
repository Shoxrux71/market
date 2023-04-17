import 'package:flutter/material.dart';
import 'package:market/moduls/product.dart';
import 'package:market/providers/products.dart';
import 'package:market/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

import '../moduls/product.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({super.key});

  void _notifyUserDelete(BuildContext context, Function() removeItem) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              'are you sure?',
              style: TextStyle(color: Colors.teal),
            ),
            content:
                const Text('Do you want to delete this product from the list?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  removeItem();
                  Navigator.of(context).pop();
                },
                child: const Text('delete'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).errorColor),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 2, left: 8, right: 8),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(product.imgUrl),
          ),
          title: Text(product.title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                splashRadius: 20,
                hoverColor: Theme.of(context).primaryColor.withOpacity(0.1),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName,
                      arguments: product.id);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              IconButton(
                splashRadius: 20,
                onPressed: () {
                  _notifyUserDelete(context, () {
                    Provider.of<Products>(context, listen: false)
                        .deleteProduct(product.id);
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
