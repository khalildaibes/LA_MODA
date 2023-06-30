import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:owanto_app/src/data/model/product.dart';
import 'package:owanto_app/src/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';

class HeaderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductViewModel prductVM = Provider.of(context, listen: false);
    var prodcuts = prductVM.listlikedProducts ?? prductVM.listProduct!["model"];
    bool isliked = prductVM.listlikedProducts == null ? false : true;
    return CarouselSlider(
      options: CarouselOptions(
        height: 400,
        autoPlay: false,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        enlargeCenterPage: true,
        pauseAutoPlayOnManualNavigate: true,

        // autoPlay: false,
      ),
      items: prodcuts!
          .map((product) => Builder(
                builder: (BuildContext context) => Container(
                    height: 400,
                    width: 500,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: isliked
                        ? getimage(product)
                        : Image.asset(
                            product.urlImage!.values.first,
                            fit: BoxFit.fitWidth,
                          )),
              ))
          .toList(),
    );
  }

  getimage(product) {
    File imageFile = File(product!.urlImage!.values.first);
    ImageProvider imageProvider = FileImage(imageFile);
    return Ink(
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
          // if (product != null) {
          //   if (prductVM.listlikedProducts == null) {
          //     prductVM.listlikedProducts = [product!];
          //   }
          //   prductVM.listlikedProducts!.add(product!);
          // }
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
    );
    return imageProvider;
  }
}
