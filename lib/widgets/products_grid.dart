import 'package:flutter/material.dart';
import 'package:market/moduls/product.dart';
import 'package:market/providers/products.dart';
import 'package:provider/provider.dart';
import './product_item.dart';
import '../moduls/product.dart';

class ProductsGrid extends StatefulWidget {
  final bool liked;
  const ProductsGrid(
    this.liked, {
    super.key,
  });

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  late Future _productsFuture;

  Future _getProductsFuture() {
    return Provider.of<Products>(context, listen: false)
        .getProductsFromFireBase();
  }

  @override
  void initState() {
    _productsFuture = _getProductsFuture();
    super.initState();
  }

  // var _init = true;
  // var _isLoading = false;

  // @override
  // void initState() {
  //   // Future.delayed(Duration.zero).then((value) {
  //   //   Provider.of<Products>(context, listen: false).getProductsFromFireBase();
  //   // });
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  //   if (_init) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     // Provider.of<Products>(context, listen: false)
  //     //     .getProductsFromFireBase()
  //         .then((responce) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   }
  //   _init = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    // ==========================
    // final productData = Provider.of<Products>(context);

    // ==========================

    return FutureBuilder(
      future: _productsFuture,
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (dataSnapshot.error == null) {
            return Consumer<Products>(
              builder: (c, products, child) {
                final ps = widget.liked ? products.like : products.list;

                return ps.isNotEmpty
                    ? GridView.builder(
                        padding: const EdgeInsets.all(20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 3 / 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        itemCount: ps.length,
                        itemBuilder: (ctx, i) {
                          return ChangeNotifierProvider<Product>.value(
                            value: ps[i],
                            child: const ProductItem(
                                // img: product[i].imgUrl,
                                // titlee: product[i].title,
                                // productId: product[i].id,
                                ),
                          );
                        },
                      )
                    : const Center(
                        child: Text('no Product'),
                      );
              },
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        }
      },
    );
  }
}
