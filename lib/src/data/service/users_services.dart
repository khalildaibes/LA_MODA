import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as fireStore;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:owanto_app/src/data/model/User.dart';
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
  List<App_User> users_list = [];
  Map<String, List<Product>> Users_info_list = {};

  Future<List<App_User>> getUsersFromFirestore(String collection) async {
    users_list = [];
    await FirebaseFirestore.instance
        .collection(collection)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (QueryDocumentSnapshot element in querySnapshot.docs) {
        users_list.add(App_User.fromFirestore(element));
      }
    });
    return users_list;
  }

  Future<List<Product>> getListdicountProduct() async {
    return listdiscountedProducts;
  }
}
