import 'package:flutter/material.dart';
import 'package:market/providers/cart.dart';
import 'package:market/providers/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_list_item.dart';
import '../widgets/app_drawer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Basket'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 0),
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const Spacer(),
                    Chip(
                      label: Text(
                        '\$ ${cart.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addToOrders(
                            cart.items.values.toList(), cart.totalPrice);
                        cart.clearCart();
                      },
                      child: const Text(
                        'Buy',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (ctx, i) {
                    final cartItem = cart.items.values.toList()[i];
                    return CartListItem(
                        productId: cart.items.keys.toList()[i],
                        imageUrl: cartItem.img,
                        title: cartItem.title,
                        price: cartItem.price,
                        quantity: cartItem.quantity);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
