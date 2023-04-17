import 'package:flutter/material.dart';
import 'package:market/moduls/product.dart';
import 'package:market/providers/products.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _form = GlobalKey<FormState>();
  final _imageForm = GlobalKey<FormState>();
  var _product = Product(
    describtion: '',
    id: '',
    imgUrl: '',
    price: 0.0,
    title: '',
  );
  var _hasImg = true;
  var _init = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_init) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      print(productId);
      if (productId != null) {
        final _editingProduct =
            Provider.of<Products>(context).findById(productId as String);
        _product = _editingProduct;
      }
    }
    _init = false;
  }

  // final _priceFocus = FocusNode();
  // FocusNode qilingandan keyn Dispose ni yoqw kere va ulangan focusni dosposega ulaw kere,bomasa hotirda yigiladi,o'cirilgandan keyn ham!!!
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _priceFocus.dispose();
  }

  void _showImgDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'enter Img-URL',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          content: Form(
            key: _imageForm,
            child: TextFormField(
              initialValue: _product.imgUrl,
              validator: (urValue) {
                if (urValue == null || urValue.isEmpty) {
                  return 'enter url link';
                } else if (!urValue.startsWith('http')) {
                  return 'enter only URL image!';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Img-Url',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
              onSaved: (newValue) {
                _product = Product(
                    describtion: _product.describtion,
                    id: _product.id,
                    imgUrl: newValue!,
                    price: _product.price,
                    title: _product.title,
                    isFavorite: _product.isFavorite);
              },
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('cancel'),
                ),
                ElevatedButton(
                    onPressed: saveImageForm, child: const Text('save')),
              ],
            ),
          ],
        );
      },
    );
  }

  void saveImageForm() {
    final imgUrlValid = _imageForm.currentState!.validate();
    if (imgUrlValid) {
      _imageForm.currentState!.save();
      print(_product.imgUrl);

      Navigator.of(context).pop();
      setState(() {
        _hasImg == true;
      });
    }
  }

  void _saveForm() {
    FocusScope.of(context).unfocus();
    final isValid = _form.currentState!.validate();
    setState(() {
      _hasImg = _product.imgUrl.isNotEmpty;
    });
    if (isValid && _hasImg) {
      _form.currentState!.save();
      if (_product.id.isEmpty) {
        Provider.of<Products>(context, listen: false).addProduct(_product);
      } else {
        Provider.of<Products>(context, listen: false).updatedProduct(_product);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('add Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save_alt),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: _product.title,
                  decoration: const InputDecoration(
                    labelText: 'Name Product',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter product name!';
                    } else if (value.length <= 3) {
                      return 'name must be more 3 letter';
                    }
                    return null;
                  },
                  // onFieldSubmitted: (_) {
                  //   FocusScope.of(context).requestFocus(_priceFocus);
                  // },
                  onSaved: (newValue) {
                    _product = Product(
                        describtion: _product.describtion,
                        id: _product.id,
                        imgUrl: _product.imgUrl,
                        price: _product.price,
                        title: newValue!,
                        isFavorite: _product.isFavorite);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  initialValue: _product.price == 0
                      ? ''
                      : _product.price.toStringAsFixed(2),
                  decoration: const InputDecoration(
                    labelText: 'Price Product',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (newValue) {
                    _product = Product(
                        describtion: _product.describtion,
                        id: _product.id,
                        imgUrl: _product.imgUrl,
                        price: double.parse(newValue!),
                        title: _product.title,
                        isFavorite: _product.isFavorite);
                  },
                  textInputAction: TextInputAction.next,
                  validator: (priceValue) {
                    if (priceValue == null || priceValue.isEmpty) {
                      return 'please enter price-product';
                    } else if (double.tryParse(priceValue) == null) {
                      return 'Please enter a number only!';
                    } else if (double.parse(priceValue) < 1) {
                      return 'number must be greater than 0';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  // focusNode: _priceFocus,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  initialValue: _product.describtion,
                  validator: (describtionValue) {
                    if (describtionValue == null || describtionValue.isEmpty) {
                      return 'please enter describtin';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'describtion',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  onSaved: (newValue) {
                    _product = Product(
                        describtion: newValue!,
                        id: _product.id,
                        imgUrl: _product.imgUrl,
                        price: _product.price,
                        title: _product.title,
                        isFavorite: _product.isFavorite);
                  },
                  maxLines: 4,
                  // focusNode: _priceFocus,
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  margin: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: _hasImg ? Colors.grey : Colors.red),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () => _showImgDialog(context),
                    splashColor: Theme.of(context).primaryColorLight,
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: _product.imgUrl.isEmpty
                          ? Text(
                              'enter URL img!',
                              style: TextStyle(
                                  color: _hasImg
                                      ? Colors.black
                                      : Theme.of(context).errorColor),
                            )
                          : Image.network(
                              _product.imgUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
