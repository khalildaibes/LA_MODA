import 'package:owanto_app/src/data/model/address.dart';
import 'package:owanto_app/src/data/model/inventory.dart';
import 'package:owanto_app/src/data/model/cart.dart';
import 'package:owanto_app/src/data/model/order.dart';
import 'package:owanto_app/src/data/model/product.dart';
import 'package:flutter/cupertino.dart';

class CartViewModel extends ChangeNotifier {
  List<Cart> listCart = [];
  int curr = 1;
  bool isFound = true;
  String message = '';
  double total = 0;
  int productCount = 0;
  List<Order> listOrder = [];

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
        var index = listCart[i]
            .product
            ?.inventory
            ?.indexWhere((element) => element.id == inventoryy.id);
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

  void checkOutCart() {
    listOrder.add(Order(
        createAt: "12-10-2023",
        total: total.toString(),
        listItemCart: listCart,
        address: Address(
            userName: "נחף",
            addressTitle1: "כתובת ראשית",
            addressTitle2: "",
            phone: "0509977084"),
        orderNumber: "098765456789"));
  }
}
