import 'package:flutter/material.dart';
import 'package:owanto_app/src/data/model/product.dart';

class ProductItemCase extends StatelessWidget {
  final Product? product;

  const ProductItemCase({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Ink(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                scale: 25 / 3,
                fit: BoxFit.contain,
                image: !product!.urlImage!.first.toString().startsWith("assets")
                    ? NetworkImage(product!.urlImage!.first.toString())
                    : AssetImage(product!.urlImage!.first) as ImageProvider,
              ),
            ),
            child: InkWell(
              onTap: () {
                final snackBar = SnackBar(
                  content: const Text('تكبسش هون ولا'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              splashColor: Colors.brown.withOpacity(0.5),
            ),
          ),
          // Image.asset(
          //   product!.urlImage!.first,
          //   fit: BoxFit.contain,
          //   scale: 25 / 3,
          // ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(product!.title!),
                IconButton(
                  icon: Icon(Icons.favorite_border_sharp),
                  onPressed: () {
                    print("DEBUG: Like button Pressed");
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Text(product!.description!),
          ),

          Spacer(),
        ],
      ),
    );
  }
}
