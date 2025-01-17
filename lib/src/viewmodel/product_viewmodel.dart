import 'package:owanto_app/src/data/model/product.dart';
import 'package:owanto_app/src/data/service/product_service.dart';
import 'package:flutter/material.dart';

class ProductViewModel extends ChangeNotifier {
  ProductService? productService = ProductService();
  Map<String, List<Product>>? listProduct;
  List<Product>? listdiscountedProducts;
  List<Product>? listlikedProducts = <Product>[];
  List<Product>? listRecent = <Product>[];
  bool isLoading = false;
  int? isLikee = 0;
  int selectIndex = 0;
  Product? productt;

  Future<List<Product>>? getListProduct() {
    isLoading = true;
    notifyListeners();
    listProduct = productService?.products_objects_list;
    isLoading = false;
    notifyListeners();
  }

  Future likeProduct(Product product) async {
    print(product.title);
  }

  addRecentView(Product product) {
    if (listRecent!.isEmpty) {
      listRecent?.add(product);
    } else {
      if (listRecent!.contains(product)) {
      } else {
        listRecent?.add(product);
      }
    }
  }

  listlikedproducts_has_category(String catregory) {
    for (Product item in listlikedProducts!) {
      if (item.category!.containsValue(catregory)) return true;
    }
    return false;
  }

  chooseOption(int index) {
    selectIndex = index;
    notifyListeners();
  }
}
