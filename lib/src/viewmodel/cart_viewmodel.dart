import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:owanto_app/src/const/globals.dart';
import 'package:owanto_app/src/data/model/address.dart';
import 'package:owanto_app/src/data/model/inventory.dart';
import 'package:owanto_app/src/data/model/cart.dart';
import 'package:owanto_app/src/data/model/order.dart';
import 'package:owanto_app/src/data/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:owanto_app/src/viewmodel/address_viewmodel.dart';
import 'package:provider/provider.dart';

class CartViewModel extends ChangeNotifier {
  List<Cart> listCart = [];
  int curr = 1;
  bool isFound = true;
  String message = '';
  double total = 0;
  int productCount = 0;
  List<Order> listOrder = [];
  Cart cart = Cart();

  addToCart(Product product, Inventory inventoryy) {
    productCount = 0;
    if (listCart.isEmpty) {
      listCart.add(
        Cart().copyWith(
          product: product.copyWith(inventory: [inventoryy]),
        ),
      );
      productCount = listCart.length;
      print('ריק ${productCount}');
    } else {
      for (int i = 0; i < listCart.length; i++) {
        var index = listCart[i].product?.inventory?.indexWhere((element) =>
            element.pid == inventoryy.pid &&
            element.size == inventoryy.size &&
            element.colors == inventoryy.colors);
        debugPrint("מספר ${index}");
        if (index != -1) {
          if (listCart[i].quantity < inventoryy.stockQuantity!) {
            listCart[i].quantity++;
          } else {
            message = "הכמות לא מספיקה";
          }
        } else {
          isFound = false;
        }
      }
      if (!isFound) {
        listCart.add(
          Cart().copyWith(
            product: product.copyWith(inventory: [inventoryy]),
          ),
        );
        notifyListeners();
      }

      productCount += listCart.length;
      print('לא ריק ${productCount}');
    }
    calculatePrice();
    notifyListeners();
  }

  void calculatePrice() {
    total = 0;
    listCart.forEach((element) {
      total += element.product!.price! * element.quantity;
    });
    notifyListeners();
  }

  Future increQuantity(Cart order, Inventory inventory) async {
    if (order.quantity < inventory.stockQuantity!) {
      order.quantity++;
    } else {
      message = "הכמות לא מספיקה";
    }
    calculatePrice();
    notifyListeners();
  }

  void deceQuanity(Cart order) {
    if (order.quantity > 1) {
      order.quantity--;
    } else {}
    calculatePrice();
    notifyListeners();
  }

  void removeCart(int index) {
    listCart.removeAt(index);
    if (productCount != 0) {
      productCount--;
    }
    calculatePrice();
    notifyListeners();
  }

  void checkOutCart(context) {
    var random = Random();
    var min = 1000000000;
    var max = 4294967296;
    var randomNumber = min + random.nextInt(max - min);
    print(randomNumber);
    var user = getCurrentUser();

    final addressViewModel =
        Provider.of<AddressViewModel>(context, listen: false);
    listOrder.add(Order(
        createAt: "12-10-2023",
        total: total.toString(),
        listItemCart: listCart,
        address: Address(
            userName: user!["name"].toString(),
            addressTitle1:
                addressViewModel.listAddress.first.addressTitle1 ?? "",
            addressTitle2:
                addressViewModel.listAddress.first.addressTitle2 ?? "",
            phone: user["phone"].toString()),
        orderNumber: randomNumber.toString()));
  }
}
