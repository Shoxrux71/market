import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:market/moduls/order.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import 'package:market/widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen({super.key});

  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future _ordersFuture;
  Future _getOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).getOrdersFromFirebase();
  }
  // var _isLoading = false;

  @override
  void initState() {
    _ordersFuture = _getOrdersFuture();
    // Future.delayed(Duration.zero).then(
    //   (_) => {
    //     setState(
    //       () {
    //         _isLoading = true;
    //       },
    //     ),
    //     Provider.of<Orders>(context, listen: false)
    //         .getOrdersFromFirebase()
    //         .then(
    //           (_) => {
    //             setState(
    //               () {
    //                 _isLoading = false;
    //               },
    //             ),
    //           },
    //         ),
    //   },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orders = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Buy list'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: _ordersFuture,
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (dataSnapshot.error == null) {
                  return Consumer<Orders>(
                    builder: (context, orders, child) => orders.items.isEmpty
                        ? const Center(
                            child: Text('no Orders!'),
                          )
                        : ListView.builder(
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
                } else {
                  return const Center(
                    child: Text('Error!'),
                  );
                }
              }
            })
        // _isLoading
        //     ? const Center(
        //         child: CircularProgressIndicator(),
        //       )
        // :

        );
  }
}
