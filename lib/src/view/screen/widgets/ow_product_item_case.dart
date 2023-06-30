import 'dart:io';

import 'package:flutter/material.dart';
import 'package:owanto_app/src/data/model/cart.dart';
import 'package:owanto_app/src/data/model/inventory.dart';
import 'package:owanto_app/src/data/model/product.dart';
import 'package:owanto_app/src/view/screen/cart_tab.dart';
import 'package:owanto_app/src/view/screen/detail_product_screen.dart';
import 'package:owanto_app/src/viewmodel/cart_viewmodel.dart';
import 'package:owanto_app/src/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:owanto_app/src/router/router_path.dart';

class ProductItemCase extends StatelessWidget {
  final Product? product;

  const ProductItemCase({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductViewModel prductVM = Provider.of(context, listen: false);
    File file = File(product!.urlImage!.values.first.toString());
    Image image = Image.file(file);
    ImageProvider<Object> imageProvider = image.image;
    return Container(
      height: 200,
      width: 200,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Ink(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                scale: 25 / 3,
                fit: BoxFit.contain,
                image: imageProvider,
              ),
            ),
            child: InkWell(
              onTap: () {
                if (product != null) {
                  if (prductVM.listlikedProducts == null) {
                    prductVM.listlikedProducts = [product!];
                  }
                  if (!prductVM.listlikedProducts!.contains(product)) {
                    prductVM.listlikedProducts!.add(product!);
                  }
                  CartViewModel cartVM = Provider.of(context, listen: false);

                  Inventory inv = new Inventory(
                      pid: "10",
                      colors: "red",
                      colors_hex: "#F00",
                      size: "XL",
                      stockQuantity: 2);
                  // cartVM.addToCart(product!, inv);
                  Navigator.pushNamed(context, DetailProductScreens,
                      arguments: product);
                }
                final snackBar = SnackBar(
                  content: const Text(
                      'שמחים שאהבתה יש מוצרים דומים ב מוצעיםכנס תדבוק.'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              splashColor: Colors.brown.withOpacity(0.5),
            ),
          ),
          // Image.asset(
          //   product!.urlImage!.first,
          //   fit: BoxFit.contain,
          //   scale: 25 / 3,
          // ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(product!.title!.substring(0, 10) + "..."),
                IconButton(
                  icon: Icon(Icons.favorite_border_sharp),
                  onPressed: () {
                    print("DEBUG: Like button Pressed");
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Text(product!.description!.substring(0, 10) + "..."),
          ),

          Spacer(),
        ],
      ),
    );
  }
}
