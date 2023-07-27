import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/inventory.dart';
import '../model/product.dart';

List<Inventory>? inventories = [
  Inventory(pid: '1', colors: 'blue', size: '23'),
  Inventory(pid: '2', colors: 'black', size: '35'),
  Inventory(pid: '3', colors: 'blue', size: '41'),
];

class ProductService extends ChangeNotifier {
  List<Product> listdiscountedProducts = [];
  Map<String, List<Product>> products_list = {};
  Map<String, List<Product>> products_objects_list = {};
  Map<String, bool> loaded_products_list = {};
  Future<List<Product>>? get_products_by_prefix(
      String prefix, bool isLoading) async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('products');

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs
        .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    for (Product element in allData) {
      if (element.category!.containsValue(prefix)) {
        if (products_objects_list[prefix] == null ||
            products_objects_list[prefix] == []) {
          products_objects_list[prefix] = [element];
          CollectionReference _collectionRef =
              FirebaseFirestore.instance.collection('inventory');

          // Get docs from collection reference
          QuerySnapshot querySnapshot = await _collectionRef.get();

          // Get data from docs and convert map to List
          final allData = querySnapshot.docs
              .map((doc) =>
                  Inventory.fromJson(doc.data() as Map<String, dynamic>))
              .toList();
          for (Inventory inv in allData) {
            if (inv.pid == element.pid) {
              if (element.inventory != null) {
                if (!element.inventory!.contains(inv)) {
                  element.inventory!.add(inv);
                }
              } else {
                element.inventory = [inv];
              }
            }
          }
        } else {
          if (!products_objects_list[prefix]!.contains(element)) {
            CollectionReference _collectionRef =
                FirebaseFirestore.instance.collection('inventory');

            // Get docs from collection reference
            QuerySnapshot querySnapshot = await _collectionRef.get();

            // Get data from docs and convert map to List
            final allData = querySnapshot.docs
                .map((doc) =>
                    Inventory.fromJson(doc.data() as Map<String, dynamic>))
                .toList();
            for (Inventory inv in allData) {
              if (inv.pid == element.pid) {
                if (element.inventory != null) {
                  if (!element.inventory!.contains(inv)) {
                    element.inventory!.add(inv);
                  }
                } else {
                  element.inventory = [inv];
                }
              }
            }
            products_objects_list[prefix]!.add(element);
          }
          // products_objects_list[prefix] = [element];
        }
      }
    }

    notifyListeners();
    isLoading = false;
    if (products_objects_list[prefix] != null) {
      products_objects_list[prefix] = products_objects_list[prefix]!;
      for (Product element in products_objects_list[prefix]!) {
        for (var photo_url in element.urlImage!.entries) {
          if (photo_url.value.toString().contains("gs://") ||
              photo_url.value.toString().contains("http")) {
            try {
              Reference ref =
                  FirebaseStorage.instance.refFromURL(photo_url.value);
              element.urlImage![photo_url.key] = await savePhotoLocally(
                  ref, prefix, element, photo_url.key.toString());
            } on Exception catch (e) {
              debugPrint("error getting the url for procuct " +
                  element.pid.toString());
            }
          }
        }
      }
      this.products_objects_list = products_objects_list;
      save_localy_photos(products_objects_list);
      loaded_products_list[prefix] = true;
    }
    return products_objects_list[prefix] ?? [];
  }

  Future<String> savePhotoLocally(
      Reference ref, String prefix, Product product, String photo_key) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String imageUrl = await ref.getDownloadURL();
    String localPath =
        '${appDocDir.path}/assets/${prefix}_${product.pid}_${photo_key}';

    File localFile = File(localPath);
    // if (localFile.existsSync()) {
    //   return localPath;
    // }

    try {
      await FirebaseStorage.instance
          .ref("/" + ref.fullPath)
          .writeToFile(localFile);
      print(localPath);

      return localPath;
    } catch (e) {
      print('Error saving photo locally: $e');
      return '';
    }
  }

  bool is_photo_synced_func(String path, String prefix) {
    try {
      if (products_list[prefix]!.isNotEmpty) {
        for (Product p in products_list[prefix]!) {
          if (p.urlImage.toString() == path.toString()) {
            return true;
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<List<Product>> fetchPhotosWithPrefix(
      String path, String prefix, bool isLoading) async {
    List<String> photoUrls = [];
    List<Product> temp = [];
    isLoading = true;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove('${prefix}_products_photos');
    try {
      firebase_storage.ListResult result = await firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child(path)
          .listAll();

      List<Reference> photos = [];
      // for (var ref in result.items) {
      //   if (ref.name.startsWith(prefix.toString())) {
      //     await savePhotoLocally(ref, ref.name).then((String localPath) {
      //       if (localPath.isNotEmpty) {
      //         Reference reference =
      //             FirebaseStorage.instance.ref().child(localPath);
      //         photos.add(reference);
      //       } else {
      //         debugPrint('${ref} was not saved.');
      //       }
      //     });
      //   }
      // }
      for (var item in photos) {
        // String imageUrl = await item.getDownloadURL();
        // photoUrls.add(imageUrl);
        int index = photos.indexOf(item);
        temp.add(Product(
            pid: '$index',
            title: "פריט $index",
            description: "Description $index ",
            price: index % 2 == 0 ? index * 3000 + 2000 : index * 2500 + 2000,
            amountProduct: index,
            createAt: "10/10/2011",
            isLike: false,
            urlImage: {"1": item.fullPath.toString()},
            inventory: inventories,
            category: {"1": "Dress"}));
      }
      this.listdiscountedProducts = temp;
      notifyListeners();
      isLoading = false;
      products_list[prefix] = listdiscountedProducts;

      this.listdiscountedProducts = listdiscountedProducts;
      save_localy_photos(products_list);
      loaded_products_list[prefix] = true;
      return listdiscountedProducts;
    } catch (e) {
      print('Error fetching photos: $e');
    }
    return [];
  }

  bool check_if_saved_localy() {
    return false;
  }

  Future<void> save_localy_photos(
      Map<String, List<Product>> products_objects_list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> temp = [];
    for (var category in products_objects_list.keys) {
      var category_products = products_objects_list[category];
      category_products?.forEach((element) {
        temp.add(element.pid.toString());
      });
      prefs.setStringList('${category}_products_photos', temp);
    }
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

  Future<Map<String, List<Product>>> getListProduct() async {
    return products_objects_list;
  }

  Future<List<Product>> getListdicountProduct() async {
    return listdiscountedProducts;
  }
}
