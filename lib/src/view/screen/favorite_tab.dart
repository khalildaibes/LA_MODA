import 'package:flutter/material.dart';
import 'package:owanto_app/src/view/screen/component/hometab/header_page.dart';
import 'package:owanto_app/src/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductViewModel>(context, listen: false);
    // productProvider.listProduct!.forEach((element) {
    //   print(element.isLike);
    // });
    return SafeArea(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          HeaderPage(),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text("אין מוצר מועדף"), Icon(Icons.info_rounded)],
          ),
          const Center(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 60),
              child: Text(
                "אתה יכול להוסיף בגדים למאוהבים עלי על ידי לחיצה על כפתור הלייק",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                print("DEBUG: Favorite TAB Button presssed");
              },
              child: const Text("חזרה לדף הבית"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w300)))
        ]),
      ),
    );
  }
}
