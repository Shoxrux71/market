import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:market/providers/cart.dart';
import 'package:provider/provider.dart';

class CartListItem extends StatelessWidget {
  final String productId;
  final String imageUrl;
  final String title;
  final double price;
  final int quantity;
  const CartListItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
    required this.productId,
  });

  void _notifyUserDelete(BuildContext context, Function() removeItem) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              'are you sure?',
              style: TextStyle(color: Colors.teal),
            ),
            content: const Text(
                'Do you want to delete this product from the basket?'),
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
    final cart = Provider.of<Cart>(context, listen: false);
    return Slidable(
      key: ValueKey(productId),
      endActionPane: ActionPane(
          extentRatio: 0.27,
          motion: const BehindMotion(),
          children: [
            ElevatedButton(
              onPressed: () => _notifyUserDelete(
                context,
                () => cart.removeItem(productId),
              ),
              child: const Text('Delete'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).errorColor,
              ),
            ),
          ]),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(title),
          subtitle: Text('total: \$${(price * quantity).toStringAsFixed(2)}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => cart.removeSingleItem(productId),
                icon: Icon(Icons.remove),
                splashRadius: 20,
              ),
              Container(
                alignment: Alignment.center,
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                ),
                child: Text(
                  quantity.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              IconButton(
                onPressed: () =>
                    cart.addToCart(productId, title, imageUrl, price),
                icon: Icon(Icons.add),
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
