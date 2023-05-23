import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:owanto_app/src/data/model/product.dart';
import 'package:owanto_app/src/data/service/product_service.dart';
import 'package:owanto_app/src/view/screen/widgets/ow_product_item_case.dart';
import 'package:owanto_app/src/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class HomeHorizontalItemSection extends StatefulWidget {
  final String category;
  @override
  _HomeHorizontalItemSectionState createState() =>
      _HomeHorizontalItemSectionState();

  HomeHorizontalItemSection({
    Key? key,
    required this.category,
  }) : super(key: key);
  get_products(context, productVM) async {
    ProductViewModel prductVM = Provider.of(context, listen: false);
    // prductVM.listdiscountedProducts = await prductVM.productService
    //     ?.fetchPhotosWithPrefix("/home_page/images", "model") as List<Product>?;
  }
}

class _HomeHorizontalItemSectionState extends State<HomeHorizontalItemSection> {
  var category;
  var is_loading;

  @override
  void initState() {
    super.initState();
    category = widget.category;
    is_loading = true;
  }

  @override
  Widget build(BuildContext context) {
    ProductViewModel prductVM = Provider.of(context, listen: false);
    var result = null;
    return FutureBuilder<List<Product>>(
      future: prductVM.productService
          ?.fetchPhotosWithPrefix("/home_page/images", category, is_loading),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              height: 50, child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          result = build_items(context, prductVM, category);
        }
        return result;
      },
    );
  }

  Widget build_items(context, prductVM, category) {
    var result;
    if (prductVM.productService.listdiscountedProducts != null) {
      result = SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: prductVM.productService.products_list[category]?.length,
            reverse: true,
            padding: EdgeInsets.all(0.0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              Product? product =
                  prductVM.productService.products_list[category]?[index];
              return ProductItemCase(product: product);
            },
          ));
    } else {
      result = Text(
        "אנחנו מעדכנים לקולקציה חדשה תחזרו מאוחר יותר לראות .",
        textDirection: TextDirection.rtl,
      );
    }

    return result;
  }
}
