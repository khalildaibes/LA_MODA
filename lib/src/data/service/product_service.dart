import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:owanto_app/src/data/model/inventory.dart';
import 'package:owanto_app/src/data/model/product.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

List<Inventory>? inventories = [
  Inventory(id: '1', color: 'blue', size: '23'),
  Inventory(id: '2', color: 'black', size: '35'),
  Inventory(id: '3', color: 'blue', size: '41'),
];

class ProductService extends ChangeNotifier {
  List<Product> listdiscountedProducts = [];
  Map<String, List<Product>> products_list = {};
  List<Product> listProduct = [
    for (int i = 0; i <= 7; i++)
      Product(
          id: '$i',
          title: "פריט $i",
          description: "Description $i ",
          price: i % 2 == 0 ? i * 3000 + 2000 : i * 2500 + 2000,
          amountProduct: i,
          createAt: "10/10/2011",
          isLike: false,
          urlImage: [
            "assets/owanto/model_$i.png",
          ],
          inventory: inventories,
          category: "Dress"),
  ];

  Future<List<Product>> fetchPhotosWithPrefix(
      String path, String prefix, bool isLoading) async {
    List<String> photoUrls = [];
    List<Product> temp = [];
    isLoading = true;
    try {
      firebase_storage.ListResult result = await firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child(path)
          .listAll();

      List<Reference> photos = [];
      for (var ref in result.items) {
        if (ref.name.startsWith(prefix.toString())) {
          photos.add(ref);
        }
      }
      for (var item in photos) {
        String imageUrl = await item.getDownloadURL();
        photoUrls.add(imageUrl);
        int index = photos.indexOf(item);
        temp.add(Product(
            id: '$index',
            title: "פריט $index",
            description: "Description $index ",
            price: index % 2 == 0 ? index * 3000 + 2000 : index * 2500 + 2000,
            amountProduct: index,
            createAt: "10/10/2011",
            isLike: false,
            urlImage: [
              imageUrl,
            ],
            inventory: inventories,
            category: "Dress"));
      }
      this.listdiscountedProducts = temp;
    } catch (e) {
      print('Error fetching photos: $e');
    }
    notifyListeners();
    isLoading = false;
    products_list[prefix] = listdiscountedProducts;
    this.listdiscountedProducts = listdiscountedProducts;
    return listdiscountedProducts;
  }

  // create_listdiscountedProducts() {
  //   listdiscountedProducts = [];
  //   FutureBuilder<List<Product>>(
  //     future: fetchPhotosWithPrefix('/home_page/images', "model"),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(child: CircularProgressIndicator());
  //       } else if (snapshot.hasError) {
  //         return Center(child: Text('Error: ${snapshot.error}'));
  //       } else if (snapshot.hasData) {
  //         return ListView.builder(
  //           scrollDirection: Axis.horizontal,
  //           shrinkWrap: true,
  //           itemCount: snapshot.data!.length,
  //           itemBuilder: (context, index) {
  //             String imageUrl = snapshot.data![index];
  //           },
  //         );
  //       } else {
  //         return Center(child: Text('No photos found.'));
  //       }
  //     },
  //   );
  //   notifyListeners();
  //   return listdiscountedProducts;
  // }

  Future<List<Product>> getListProduct() async {
    return listProduct;
  }

  Future<List<Product>> getListdicountProduct() async {
    return listdiscountedProducts;
  }
}
