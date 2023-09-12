import 'package:flutter/material.dart';

class CartEmptyScreen extends StatelessWidget {
  final String message;

  const CartEmptyScreen({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(message), Icon(Icons.info_rounded)],
      )),
    );
  }
}
