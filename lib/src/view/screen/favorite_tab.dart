import 'package:flutter/material.dart';
import 'package:owanto_app/src/view/screen/component/hometab/header_page.dart';
import 'package:owanto_app/src/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';

import 'widgets/ow_header_title.dart';
import 'widgets/ow_popular_section_from_firebase.dart';
import 'widgets/ow_tuniques_section.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductViewModel>(context, listen: false);
    // productProvider.listProduct!.forEach((element) {
    //   print(element.isLike);
    // });
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          HeaderPage(),
          const SizedBox(height: 10),
          const HeaderBody(
              title: "קולקצית קיץ", description: "גלו את ה קולקציה החדשה שלנו"),
          // CollectionImageSection(),
          new HomeHorizontalItemSection(category: "antica jeans"),
          const SizedBox(height: 10),
          const HeaderBody(
              title: "הנמכרים ביותר",
              description: "גלו את ה קולקציה החדשה שלנו"),
          new HomeHorizontalItemSection(category: "all time favorite"),
          const HeaderBody(
              title: "הכי חדש", description: "גלו את ה קולקציה החדשה שלנו"),
          new HomeHorizontalItemSection(category: "brand new"),
          const SizedBox(height: 60),
          TuniqueSection(),
          const SizedBox(height: 200)
        ]),
      ),
    );
  }
}
