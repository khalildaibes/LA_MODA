// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:owanto_app/src/const/app_colors.dart';
import 'package:owanto_app/src/const/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:owanto_app/src/data/model/User.dart';
import 'package:owanto_app/src/viewmodel/auth_viemodel.dart';
import 'package:provider/provider.dart';

import 'component/addaddress/text_field_address.dart';

class RegisterScreen extends StatelessWidget {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();

  getstream() {
    debugPrint("hasDFirebaseFirestoreata");
    return FirebaseFirestore.instance.collection('users').snapshots();
  }

  Future<bool> getDataCollection(Map<String, dynamic> jsonuser) async {
    // QuerySnapshot querySnapshot =
    //     await FirebaseFirestore.instance.collection("users").get();
    // var list = querySnapshot.docs as List;\
    bool found = false;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('users');

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData =
        querySnapshot.docs.map((doc) => App_User.fromFirestore(doc)).toList();
    for (App_User element in allData) {
      if (!found) {
        element.phone == jsonuser['phone'] ? found = true : found = false;
      } else {
        continue;
      }
    }

    return found;
  }

  void register_to_db(context) async {
    const deatils = {
      "nane": "0",
      "phone": "0",
      "password": "0",
    };
    Map<String, dynamic> userjson = {
      "name": nameController.text.toString(),
      "phone": phoneController.text.toString(),
      "password": passController.text.toString(),
    };

    var found = await getDataCollection(userjson);

    if (found) {
      debugPrint("found");
    } else {
      final AuthViewModel authViewModel = AuthViewModel();
      debugPrint("here");
      await authViewModel.login(
          passController.text.toString(),
          phoneController.text.toString(),
          nameController.text.toString(),
          context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                      size: 20,
                    )),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "הרשמה",
                  style: AppFont.bold.copyWith(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFieldAddress(
                    textEditingController: nameController, lableText: "שם"),
                SizedBox(
                  height: 10,
                ),
                TextFieldAddress(
                    textEditingController: phoneController, lableText: "טלפון"),
                SizedBox(
                  height: 25,
                ),
                TextFieldAddress(
                    textEditingController: passController, lableText: "סיסמה"),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "יש לך חשבון ?",
                    style: AppFont.medium.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColorRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    onPressed: () {
                      register_to_db(context);
                    },
                    child: Text(
                      "הרשמה".toUpperCase(),
                      style: AppFont.medium
                          .copyWith(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                Spacer(),
                Center(
                  child: Text(
                    'הרשמה דרך רשתות חברתיות',
                    style: AppFont.medium.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 80,
                        height: 65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.1),
                                offset: Offset(1, 1),
                                blurRadius: 1,
                                spreadRadius: 2,
                              )
                            ]),
                        child: SvgPicture.asset(
                          'assets/image/ic_google.svg',
                          width: 10,
                          height: 10,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.1),
                                offset: Offset(1, 1),
                                blurRadius: 1,
                                spreadRadius: 2,
                              )
                            ]),
                        child: SvgPicture.asset(
                          'assets/image/ic_fb.svg',
                          width: 10,
                          height: 10,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
