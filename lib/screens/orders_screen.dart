import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:market/moduls/order.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import 'package:market/widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Buy list'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: orders.items.length,
          itemBuilder: (ctx, i) {
            final order = orders.items[i];
            return OrderItem(
              totalPrice: order.totalPrice,
              products: order.products,
              date: order.date,
            );
          }),
    );
  }
}
