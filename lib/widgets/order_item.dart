import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:market/moduls/cart_item.dart';
import 'package:market/moduls/product.dart';
import 'package:provider/provider.dart';

import '../moduls/order.dart';

class OrderItem extends StatefulWidget {
  final List<CartItem> products;
  final double totalPrice;
  final DateTime date;
  const OrderItem({
    super.key,
    required this.totalPrice,
    required this.products,
    required this.date,
  });

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expandItem = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.totalPrice}'),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.date)),
            trailing: IconButton(
              splashRadius: 20,
              onPressed: () {
                setState(() {
                  _expandItem = !_expandItem;
                });
              },
              icon: Icon(
                _expandItem ? Icons.expand_less : Icons.expand_more,
              ),
            ),
          ),
          if (_expandItem)
            Container(
              height: min(widget.products.length * 20 + 30, 100),
              child: ListView.builder(
                  itemCount: widget.products.length,
                  itemBuilder: (ctx, i) {
                    final product = widget.products[i];
                    return ListTile(
                      title: Text(
                        product.title,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      subtitle: Text('\$${product.price}'),
                      trailing: Text(
                        '${product.quantity}x   \$${product.price * product.quantity}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    );
                  }),
            )
        ],
      ),
    );
  }
}
