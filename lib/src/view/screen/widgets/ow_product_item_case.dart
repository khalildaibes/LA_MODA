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

class ProductItemCase extends StatefulWidget {
  final Product product;
  Widget border_icon = Icon(Icons.favorite_border_rounded);
  Widget colored_icon = Icon(Icons.favorite, color: Colors.red);
  bool flag = false;
  ProductItemCase(this.product);

  @override
  _ProductItemCase createState() => new _ProductItemCase();
}

class _ProductItemCase extends State<ProductItemCase> {
  @override
  Widget build(BuildContext context) {
    if (widget.product!.category == "summer") {
      debugPrint(widget.product!.urlImage.toString());
    }
    ProductViewModel prductVM = Provider.of(context, listen: false);

    if (prductVM.listlikedProducts!.contains(widget.product)) {
      widget.flag = true;
    }
    File file = File(widget.product.urlImage!.values.first.toString());
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
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                scale: 25 / 3,
                fit: BoxFit.fill,
                image: imageProvider,
              ),
            ),
            child: InkWell(
              onTap: () {
                CartViewModel cartVM = Provider.of(context, listen: false);
                Navigator.pushNamed(context, DetailProductScreens,
                    arguments: widget.product);

                // final snackBar = SnackBar(
                //   content: const Text(
                //       'שמחים שאהבתה יש מוצרים דומים ב מוצעיםכנס תדבוק.'),
                //   action: SnackBarAction(
                //     label: 'Undo',
                //     onPressed: () {
                //       // Some code to undo the change.
                //     },
                //   ),
                // );
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                Text(
                  widget.product!.title!.length > 15
                      ? widget.product!.title!.substring(0, 15) + "..."
                      : widget.product!.title!.toString(),
                  textAlign: TextAlign.end,
                ),
                IconButton(
                  icon: widget.flag == true
                      ? widget.colored_icon
                      : widget.border_icon,
                  splashColor: Colors.red.withOpacity(0.5),
                  onPressed: () {
                    if (widget.product != null) {
                      if (prductVM.listlikedProducts == null) {
                        prductVM.listlikedProducts = [widget.product!];
                      }
                      if (!prductVM.listlikedProducts!
                          .contains(widget.product)) {
                        if (widget.flag) {
                          prductVM.listlikedProducts!.remove(widget.product!);
                        } else {
                          prductVM.listlikedProducts!.add(widget.product!);
                        }
                      } else {
                        if (widget.flag) {
                          prductVM.listlikedProducts!.remove(widget.product!);
                        } else {
                          prductVM.listlikedProducts!.add(widget.product!);
                        }
                      }
                      setState(() {
                        widget.flag = !widget.flag;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Text(
              widget.product!.description!.substring(0, 10) + "...",
              textAlign: TextAlign.end,
              textDirection: TextDirection.rtl,
            ),
          ),

          Spacer(),
        ],
      ),
    );
  }
}
