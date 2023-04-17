import 'package:flutter/material.dart';
import 'package:market/providers/cart.dart';
import 'package:market/providers/orders.dart';
import './orders_screen.dart';
import 'package:market/screens/orders_screen.dart';
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
                    orderButton(cart: cart),
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

class orderButton extends StatefulWidget {
  const orderButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<orderButton> createState() => _orderButtonState();
}

class _orderButtonState extends State<orderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cart.items.isEmpty || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addToOrders(
                  widget.cart.items.values.toList(), widget.cart.totalPrice);
              setState(() {
                _isLoading = false;
              });
              widget.cart.clearCart();
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text(
              'Buy',
              style: TextStyle(fontSize: 22),
            ),
    );
  }
}
