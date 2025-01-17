import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      child: ListTile(
        leading: Icon(Icons.search),
        trailing: SizedBox(
          width: 300,
          child: TextField(
            textAlign: TextAlign.end,
            textDirection: TextDirection.rtl,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                fillColor: Colors.black,
                focusColor: Colors.black,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                // prefixText: 'Recherche des produits',
                disabledBorder: InputBorder.none,
                hintText: 'חפש מוצרים ספציפים',
                hintStyle: TextStyle()),
          ),
        ),
      ),
    );
  }
}
