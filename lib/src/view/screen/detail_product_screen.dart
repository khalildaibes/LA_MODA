import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:owanto_app/src/const/app_colors.dart';
import 'package:owanto_app/src/const/app_font.dart';
import 'package:owanto_app/src/data/model/inventory.dart';
import 'package:owanto_app/src/data/model/product.dart';
import 'package:owanto_app/src/router/router_path.dart';
import 'package:owanto_app/src/view/screen/dash_board_screen.dart';
import 'package:owanto_app/src/viewmodel/auth_viemodel.dart';
import 'package:owanto_app/src/viewmodel/cart_viewmodel.dart';
import 'package:owanto_app/src/viewmodel/choice_chip.dart';
import 'package:owanto_app/src/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/bottom_navigate_provider.dart';
import 'cart_tab.dart';

class DetailProductScreen extends StatefulWidget {
  final Product? product;
  bool flag = false;
  Widget border_icon = Icon(
    Icons.favorite_border_rounded,
    color: Colors.black,
    size: 22,
  );
  Widget colored_icon = Icon(
    Icons.favorite,
    color: Colors.red,
    size: 22,
  );

  DetailProductScreen({Key? key, this.product}) : super(key: key);

  @override
  _DetailProductScreenState createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  Inventory? inventory = Inventory();

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: true);
    final authViewModel = "kha";
    // Provider.of<AuthViewModel>(context, listen: true);
    ProductViewModel prductVM = Provider.of(context, listen: false);
    File file = File(widget.product!.urlImage!.values.first.toString());
    Image image = Image.file(file);

    if (prductVM.listlikedProducts!.contains(widget.product)) {
      widget.flag = true;
    }

    ImageProvider<Object> imageProvider = image.image;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, DashBoardScreens);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 22,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          widget.product!.title!,
          style: AppFont.semiBold,
        ),
        actions: [
          IconButton(
            icon:
                widget.flag == true ? widget.colored_icon : widget.border_icon,
            splashColor: Colors.red.withOpacity(0.5),
            color: Colors.black,
            onPressed: () {
              if (widget.product != null) {
                if (prductVM.listlikedProducts == null) {
                  prductVM.listlikedProducts = [widget.product!];
                }
                if (!prductVM.listlikedProducts!.contains(widget.product)) {
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
          IconButton(
              onPressed: () {
                // Navigator.pop(context);
                var bottomProvider = Provider.of<BottomNavigationProvider>(
                    context,
                    listen: false);
                bottomProvider.currentIndex = 1;
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DashBoardScreen()));
              },
              icon: Badge(
                badgeColor: AppColors.primaryColorRed,
                badgeContent: Text(
                  cartViewModel.productCount.toString(),
                  style: AppFont.regular
                      .copyWith(fontSize: 12, color: Colors.white),
                ),
                position: BadgePosition.topEnd(top: -8, end: -5),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
              )),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       scale: 25 / 3,
              //       fit: BoxFit.contain,
              //       image: imageProvider,
              //     ),
              //   ),

              //   // ,Image.network(widget.product!.urlImage![0]),
              // ),
              Ink(
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    scale: 6 / 5,
                    fit: BoxFit.contain,
                    image: imageProvider,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    //   if (widget.product != null) {
                    //     if (prductVM.listlikedProducts == null) {
                    //       prductVM.listlikedProducts = [widget.product!];
                    //     }
                    //     if (!prductVM.listlikedProducts!
                    //         .contains(widget.product)) {
                    //       prductVM.listlikedProducts!.add(widget.product!);
                    //     }
                    //     CartViewModel cartVM =
                    //         Provider.of(context, listen: false);

                    //     Inventory inv = new Inventory(
                    //         id: "10",
                    //         color: "red",
                    //         colorValue: "#F00",
                    //         size: "XL",
                    //         stockQuantity: 2);
                    //     // cartVM.addToCart(product!, inv);
                    //     Navigator.pushNamed(context, DetailProductScreens,
                    //         arguments: widget.product);
                    //   }
                    //   final snackBar = SnackBar(
                    //     content: const Text(
                    //         'שמחים שאהבתה יש מוצרים דומים ב מוצעיםכנס תדבוק.'),
                    //     action: SnackBarAction(
                    //       label: 'Undo',
                    //       onPressed: () {
                    //         // Some code to undo the change.
                    //       },
                    //     ),
                    //   );
                    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  splashColor: Colors.brown.withOpacity(0.5),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.product!.title!,
                            style: AppFont.bold.copyWith(fontSize: 23),
                          ),
                        ),
                        Text(
                          widget.product!.price.toString(),
                          style: AppFont.bold.copyWith(fontSize: 23),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.product!.category!.values.first,
                      style: AppFont.regular.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: 5,
                          direction: Axis.horizontal,
                          itemSize: 20,
                          itemCount: 5,
                          ignoreGestures: true,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('(10)')
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.product!.description.toString(),
                      style: AppFont.regular.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          height: 1.4,
                          letterSpacing: .2,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "דירוג",
                      style: AppFont.bold.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (BuildContext ctx) {
          return Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.2),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(2, -2),
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColorRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                onPressed: () {
                  // if (authViewModel.isLoggedIn == false) {
                  //   Navigator.pushNamed(context, LoginScreens);
                  // } else {
                  if (widget.product!.inventory != null) {
                    inventory = Inventory();
                    showChooseSize(ctx, widget.product);
                  } else {
                    Fluttertoast.showToast(
                        msg: "אין במלאי כרגע,  סחורה בדרך נעדכן בקרוב.");
                  }

                  // }
                },
                child: Text(
                  "הוספה לסל".toUpperCase(),
                  style: AppFont.medium
                      .copyWith(fontSize: 17, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  showChooseSize(BuildContext ctx, Product? product) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        ProductViewModel productViewModel = ProductViewModel(); // cre
        ProductViewModel productViewModel2 =
            ProductViewModel(); // cre// ate instance provider
        String select = '';
        Inventory? a;
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                color: Color(0xffF9F9F9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Text(
                        "מידה",
                        style: AppFont.semiBold.copyWith(fontSize: 20),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                                // padding: const EdgeInsets.only(
                                //     right: 15, bottom: 15),
                                child: ChangeNotifierProvider.value(
                              value: productViewModel,
                              child: Consumer<ProductViewModel>(
                                builder: (BuildContext context, productVM,
                                    Widget? child) {
                                  if (widget.product!.inventory == null) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "אין במלאי כרגע סחורה בדרך נעדכן בקרוב.");
                                    return Container();
                                  }
                                  return ChoiceOption(
                                    listSize: widget.product!.inventory!
                                        .map((e) => e.size!)
                                        .toSet()
                                        .toList(),
                                    onSelectCallBack: (value) {
                                      var size = widget.product!.inventory!
                                          .firstWhere((element) =>
                                              element.size == value);
                                      if (size != null) {
                                        inventory?.size = size.size;
                                        // print(inventory?.size);
                                      }
                                      if (inventory?.colors != null) {
                                        var a = widget.product!.inventory
                                            ?.firstWhere(
                                                (element) =>
                                                    element.colors ==
                                                        inventory?.colors &&
                                                    element.size ==
                                                        inventory?.size,
                                                orElse: () => Inventory());
                                        if (a?.pid != null) {
                                          print('ok');
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "אין מידות");
                                        }
                                      }
                                    },
                                  );
                                },
                              ),
                            )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "צבעים",
                        textAlign: TextAlign.right,
                        style: AppFont.semiBold.copyWith(fontSize: 20),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                                // padding: const EdgeInsets.only(
                                //     right: 15, bottom: 15),
                                child: ChangeNotifierProvider.value(
                              value: productViewModel,
                              child: Consumer<ProductViewModel>(
                                builder: (BuildContext context, productVM,
                                    Widget? child) {
                                  if (widget.product!.inventory == null) {
                                    return Container();
                                  }
                                  return Container(
                                    child: ChoiceOption(
                                      listSize: product!.inventory!
                                          .map((e) => e.colors!)
                                          .toSet()
                                          .toList(),
                                      onSelectCallBack: (value) {
                                        try {
                                          var size = product.inventory!
                                              .firstWhere((element) =>
                                                  element.colors == value);
                                          if (size != null) {
                                            if (product.inventory!
                                                .contains(size))
                                              inventory?.colors = size.colors;

                                            // print(inventory?.color);
                                          }
                                          if (inventory?.size != null) {
                                            a = product.inventory!.firstWhere(
                                                (element) =>
                                                    element.colors ==
                                                        inventory?.colors &&
                                                    element.size ==
                                                        inventory?.size);
                                            print(a?.pid);
                                            if (a != null) {
                                              print(a?.stockQuantity);
                                            } else {
                                              print('f');
                                            }
                                          }
                                        } catch (e) {
                                          Fluttertoast.showToast(
                                              msg: "אין מידות");
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColorRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                        onPressed: () {
                          // String? size = product.inventory![productViewModel.selectIndex].size;
                          // String? color = product.inventory![productViewModel.selectIndex].color;
                          Provider.of<CartViewModel>(ctx, listen: false)
                              .addToCart(product!, a!);
                          Fluttertoast.showToast(
                              msg:
                                  Provider.of<CartViewModel>(ctx, listen: false)
                                      .message);
                        },
                        child: Text(
                          "הוספה לסל".toUpperCase(),
                          style: AppFont.medium
                              .copyWith(fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildText(List<String> list) {
    return Wrap(
      children: list.map((e) => Text(e)).toList(),
    );
  }
}
