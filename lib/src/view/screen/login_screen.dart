import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:owanto_app/src/const/app_colors.dart';
import 'package:owanto_app/src/const/app_font.dart';
import 'package:owanto_app/src/data/model/User.dart';
import 'package:owanto_app/src/router/router_path.dart';
import 'package:owanto_app/src/viewmodel/auth_viemodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/globals.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  bool isShowPass = false;
  final _codeController = TextEditingController();
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
        if (element.phone == jsonuser['phone']) {
          found = true;
        } else {
          found = false;
        }
      } else {
        continue;
      }
    }
    // if (!found) {
    //   _collectionRef.add(jsonuser);
    // }
    return found;
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: true);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Center(
                    child: Column(
                  children: [
                    Text(
                      "la moda by najwa",
                      style: AppFont.title_connected.copyWith(
                        color: Colors.black,
                        fontSize: 42,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/image/lamodalogo.svg',
                      height: 100,
                      width: 300,
                      fit: BoxFit.scaleDown,
                    )
                  ],
                )),

                // TextFieldAddress(vi
                //     textEditingController: emailController, lableText: "Email"),

                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.2),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ]),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 30.0, 0),
                      child: TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "מספר טלפון",
                          alignLabelWithHint: false,
                          labelStyle: AppFont.regular.copyWith(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.2),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ]),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 30.0, 0),
                      child: TextFormField(
                        controller: passController,
                        obscureText: isShowPass,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "סיסמה",
                          alignLabelWithHint: false,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isShowPass = !isShowPass;
                                });
                              },
                              child: Icon(
                                isShowPass
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 16,
                              )),
                          labelStyle: AppFont.regular.copyWith(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, ForgotPassScreens),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        "שכחתי את הסיסמה",
                        style: AppFont.medium.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(
                      activeColor: AppColors.primaryColorRed,
                      value: false,
                      onChanged: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: Text(
                        "זכור אותי",
                        style: AppFont.medium.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColorBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onPressed: () async {
                      Map<String, dynamic> userjson = {
                        "name": nameController.text.toString(),
                        "phone": phoneController.text.toString(),
                        "password": passController.text.toString(),
                      };
                      if (await getDataCollection(userjson)) {
                        Navigator.pushNamed(context, DashBoardScreens);
                      }

                      // Navigator.pushReplacementNamed(
                      //     context, RegisterScreens))
                      ;
                      // Navigator.pushReplacementNamed(context, DashBoardScreens);
                    },
                    child: Text(
                      "התחברות".toUpperCase(),
                      style: AppFont.medium
                          .copyWith(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreens);
                  },
                  child: Center(
                      child: RichText(
                    text: TextSpan(
                        text: "אין לכם חשבון תרשם עכשיו  ",
                        style: AppFont.medium.copyWith(fontSize: 16),
                        children: [
                          TextSpan(
                            text: " יצירו חשבון עכשיו ",
                            style: AppFont.bold.copyWith(
                                fontSize: 16, color: AppColors.primaryColorRed),
                          )
                        ]),
                  )),
                ),
                SizedBox(
                  height: 10,
                ),

                Center(
                  child: Text(
                    'או',
                    style: AppFont.medium.copyWith(
                      fontSize: 16,
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
