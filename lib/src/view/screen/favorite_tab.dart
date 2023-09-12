import 'package:flutter/material.dart';
import 'package:owanto_app/src/data/model/product.dart';
import 'package:owanto_app/src/view/screen/component/hometab/header_page.dart';
import 'package:owanto_app/src/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../data/model/category.dart';
import '../../data/service/category_service.dart';
import 'component/carttab/cart_empty_screen.dart';
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
    ProductViewModel prductVM = Provider.of(context, listen: false);
    var prodcuts = prductVM.listlikedProducts;
    bool isliked = prductVM.listlikedProducts == null ? false : true;
    if (prodcuts!.isEmpty) {
      return CartEmptyScreen(
        message: 'אין לך מוצרים ב מעודפים',
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          HeaderPage(),
          FutureBuilder<List<Category>>(
            future: CategoryService().get_categories_from_db(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    height: 50,
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    if (prductVM.listlikedproducts_has_category(
                        snapshot.data![index].name.toString())) {
                      return Column(children: [
                        HeaderBody(
                            title: snapshot.data![index].name.toString(),
                            description:  snapshot.data![index].slogan.toString()),
                        // CollectionImageSection(),
                        new HomeHorizontalItemSection(
                            category: snapshot.data![index].name ?? "",
                            favorit: true)
                      ]);
                    } else {
                      return Container();
                    }
                  },
                );
              }
            },
          ),

          // const SizedBox(height: 60),
          // TuniqueSection(),
          // const SizedBox(height: 200)
        ]),
      ),
    );
  }
}
