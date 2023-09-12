import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/category.dart';
import '../model/inventory.dart';
import '../model/product.dart';


class CategoryService extends ChangeNotifier {
  List<Category> categories= [];
  Future<List<Category>>? get_categories_from_db() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('category');

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    categories = querySnapshot.docs
        .map((doc) => Category.fromJson(doc.data() as Map<String, dynamic>))
        .toList();


    notifyListeners();
   
    return categories;
  }

  Future<List<Category>> getCategoriesList() async {
    return categories;
  }

}
