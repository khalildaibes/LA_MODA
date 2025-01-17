import 'package:flutter/material.dart';
import 'package:owanto_app/src/data/model/product.dart';
import 'package:owanto_app/src/view/screen/widgets/ow_product_item_case.dart';
import 'package:owanto_app/src/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';

class PopularSection extends StatelessWidget {
  const PopularSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductViewModel prductVM = Provider.of(context, listen: false);
    return SizedBox(
        height: 300,
        child: ListView.builder(
          itemCount: prductVM.listProduct?.length,
          reverse: true,
          padding: EdgeInsets.all(0.0),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            Product? product = prductVM.listProduct!["model"]![index];
            return ProductItemCase(product);
          },
        ));
  }
}
