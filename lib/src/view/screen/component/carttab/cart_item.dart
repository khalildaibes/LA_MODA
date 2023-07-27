import 'dart:io';

import 'package:owanto_app/src/const/app_font.dart';
import 'package:owanto_app/src/data/model/cart.dart';
import 'package:owanto_app/src/viewmodel/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final Cart order;

  const CartItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: true);
    File file = File(order.product!.urlImage!["1"].toString());
    Image image = Image.file(file);
    ImageProvider<Object> imageProvider = image.image;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.product!.title!,
                    overflow: TextOverflow.ellipsis,
                    style: AppFont.semiBold.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "צבע: ",
                              style: AppFont.regular.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                              children: [
                                TextSpan(
                                  text: order.product!.inventory![0].colors,
                                  style: AppFont.regular.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                )
                              ]),
                        ]),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "מידה: ",
                              style: AppFont.regular.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                              children: [
                                TextSpan(
                                  text: order.product!.inventory![0].size,
                                  style: AppFont.regular.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                )
                              ]),
                        ]),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text("${order.product!.price!} ₪"),
                      Spacer(),
                      Container(
                        width: 100,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.withOpacity(.1),
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  cartViewModel.increQuantity(
                                      order, order.product!.inventory![0]);
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                              ),
                              flex: 1,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(order.quantity.toString()),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  cartViewModel.deceQuanity(order);
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 18,
                                ),
                              ),
                              flex: 1,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Ink(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                scale: 25 / 3,
                fit: BoxFit.contain,
                image: imageProvider,
              ),
            ),
            child: InkWell(
              onTap: () {},
              splashColor: Colors.brown.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
