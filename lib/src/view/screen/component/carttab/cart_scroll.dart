import 'package:owanto_app/src/const/app_colors.dart';
import 'package:owanto_app/src/const/app_font.dart';
import 'package:owanto_app/src/const/globals.dart';
import 'package:owanto_app/src/data/model/address.dart';
import 'package:owanto_app/src/data/model/cart.dart';
import 'package:owanto_app/src/router/router_path.dart';
import 'package:owanto_app/src/viewmodel/address_viewmodel.dart';
import 'package:owanto_app/src/viewmodel/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_item.dart';

class CartScroll extends StatelessWidget {
  final List<Cart> listCart;
  const CartScroll({Key? key, required this.listCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: true);
    final addressViewModel =
        Provider.of<AddressViewModel>(context, listen: true);
    int priceShip = 15;
    if (addressViewModel.listAddress.isEmpty) {
      Address add = Address(
          id: "1",
          userName: "khalil",
          phone: "0509977084",
          addressTitle1: "nahef alaen st2 ",
          addressTitle2: "nahef alaen st2 ");
      addressViewModel.listAddress.add(add);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              buildTextHeader(title: "כתובת משלוח"),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.1),
                        blurRadius: 4,
                        spreadRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, ChoiceAddressScreens);
                          },
                          child: Text(
                            "שינוי",
                            style: AppFont.regular.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: AppColors.primaryColorRed),
                          ),
                        ),
                        Spacer(),
                        Text(
                          getCurrentUser()!["name"] ?? "משתמש ",
                          textDirection: TextDirection.rtl,
                          style: AppFont.medium.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      getCurrentUser()!["phone"],
                      textDirection: TextDirection.rtl,
                      style: AppFont.regular.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      addressViewModel.listAddress.first.addressTitle1
                          .toString(),
                      textDirection: TextDirection.rtl,
                      style: AppFont.regular.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(0.0),
                itemCount: listCart.length,
                itemBuilder: (_, index) {
                  Cart order = listCart[index];
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (value) {
                      cartViewModel.removeCart(index);
                    },
                    background: Container(
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    child: CartItem(
                      order: order,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Text(
                    "שינוי",
                    style: AppFont.regular.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: AppColors.primaryColorRed),
                  ),
                  Spacer(),
                  buildTextHeader(title: "שיטת תשלום"),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Text(
                    "₪ ${cartViewModel.total}",
                    style: AppFont.semiBold.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  Spacer(),
                  Text(
                    " מחיר הזמנה",
                    textDirection: TextDirection.rtl,
                    style: AppFont.medium.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: AppColors.primaryColorGray),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "₪ $priceShip",
                    style: AppFont.semiBold.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "משלוח",
                    style: AppFont.medium.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: AppColors.primaryColorGray),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "₪ ${cartViewModel.total + priceShip}",
                    style: AppFont.semiBold.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "סיכום",
                    style: AppFont.medium.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.primaryColorGray),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 120,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Container(
          width: double.infinity,
          child: Row(
            children: [
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "סכ״ה",
                    style: AppFont.medium.copyWith(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${cartViewModel.total + priceShip} ₪ ",
                    textDirection: TextDirection.rtl,
                    style: AppFont.semiBold
                        .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColorRed,
                          textStyle: AppFont.medium.copyWith(
                              fontSize: 15, fontWeight: FontWeight.normal)),
                      onPressed: () {
                        cartViewModel.checkOutCart(context);
                        // Navigator.pushNamed(context, OrderSuccessScreens),
                      },
                      child: Text('אישור'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextHeader({required String title}) {
    return Container(
      alignment: Alignment.topRight,
      child: Text(
        title,
        textAlign: TextAlign.end,
        textDirection: TextDirection.rtl,
        style: AppFont.semiBold
            .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }
}
