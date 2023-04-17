import 'package:flutter/material.dart';
import 'package:market/screens/home_screen.dart';
import '../screens/manage_product_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text('Menu'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text(
              'Magazine',
              style: TextStyle(
                  fontSize: 18, color: Theme.of(context).primaryColor),
            ),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(HomeScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: Text(
              'Orders',
              style: TextStyle(
                  fontSize: 18, color: Theme.of(context).primaryColor),
            ),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                  fontSize: 18, color: Theme.of(context).primaryColor),
            ),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ManageProductsScreen.routeNamwe),
          ),
        ],
      ),
    );
  }
}
