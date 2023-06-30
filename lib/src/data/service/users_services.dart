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
  Inventory(pid: '1', colors: 'blue', size: '23'),
  Inventory(pid: '2', colors: 'black', size: '35'),
  Inventory(pid: '3', colors: 'blue', size: '41'),
];

class UserService extends ChangeNotifier {
  List<Product> listdiscountedProducts = [];
  User? currentUser;
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
}
