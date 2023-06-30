import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:owanto_app/src/data/model/product.dart';
import 'package:owanto_app/src/data/service/product_service.dart';
import 'package:owanto_app/src/view/screen/widgets/ow_product_item_case.dart';
import 'package:owanto_app/src/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class HomeBannerItemSection extends StatefulWidget {
  final String photo_name;
  @override
  _HomeBannerItemSectionState createState() => _HomeBannerItemSectionState();

  HomeBannerItemSection({
    Key? key,
    required this.photo_name,
  }) : super(key: key);
  get_products(context, productVM) async {
    ProductViewModel prductVM = Provider.of(context, listen: false);
    // prductVM.listdiscountedProducts = await prductVM.productService
    //     ?.fetchPhotosWithPrefix("/home_page/images", "model") as List<Product>?;
  }
}

class _HomeBannerItemSectionState extends State<HomeBannerItemSection> {
  var photo_name;
  var is_loading;

  @override
  void initState() {
    super.initState();
    photo_name = widget.photo_name;
    is_loading = true;
  }

  @override
  Widget build(BuildContext context) {
    ProductViewModel prductVM = Provider.of(context, listen: false);
    var result = null;
    if (prductVM.productService!.loaded_products_list[photo_name] == true) {
      result = build_items(context, prductVM, photo_name);
      return result;
    }
    return FutureBuilder<List<Product>>(
      future: prductVM.productService!
          .get_products_by_prefix(photo_name, is_loading),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              height: 50, child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          result = build_items(context, prductVM, photo_name);
        }
        return result;
      },
    );
  }

  Widget build_items(context, ProductViewModel prductVM, prefix) {
    var result;

    if (prductVM.productService!.listdiscountedProducts != null) {
      Product? product = prductVM
          .productService!.products_objects_list![prefix]!
          .firstWhere((element) => element.category!.containsValue(prefix));
      debugPrint(product!.urlImage!.values.first.toString());
      result = SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * .9,
                child: Image.file(
                    File(product!.urlImage!.values.first.toString()))),
          ),
        ),
      );
    } else {
      result = Text(
        "אנחנו מעדכנים לקולקציה חדשה תחזרו מאוחר יותר לראות .",
        textDirection: TextDirection.rtl,
      );
    }

    return result;
  }
}
