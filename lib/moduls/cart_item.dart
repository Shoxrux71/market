class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String img;

  CartItem({
    required this.id,
    required this.img,
    required this.price,
    required this.quantity,
    required this.title,
  });
}
