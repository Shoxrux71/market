import 'package:flutter/material.dart';

class CustomCart extends StatelessWidget {
  final Widget iconChild;
  final String number;
  const CustomCart({
    super.key,
    required this.iconChild,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        iconChild,
        Positioned(
          top: 17,
          child: Container(
            alignment: Alignment.center,
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              number,
              style: const TextStyle(fontSize: 8),
            ),
          ),
        )
      ],
    );
  }
}
