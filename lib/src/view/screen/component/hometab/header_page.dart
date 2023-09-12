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
    var prodcuts = prductVM.listlikedProducts;
    bool isliked = prductVM.listlikedProducts == null ? false : true;
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * .55,
        autoPlay: false,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        enlargeCenterPage: true,
        pauseAutoPlayOnManualNavigate: true,

        // autoPlay: false,
      ),
      items: prodcuts!
          .map((product) => Builder(
                builder: (BuildContext context) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 0,
                    ),
                    Container(
                        height: 350,
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
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .6,
                          child: Text(
                            product.description.toString() + ".",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          alignment: Alignment.topRight,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .55,
                          child: Text(
                            "מחיר:  ₪" + product.price.toString(),
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          alignment: Alignment.topCenter,
                        ),
                      ],
                    )
                  ],
                ),
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
