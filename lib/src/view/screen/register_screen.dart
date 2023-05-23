// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:owanto_app/src/const/app_colors.dart';
import 'package:owanto_app/src/const/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'component/addaddress/text_field_address.dart';

class RegisterScreen extends StatelessWidget {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();

  void register_to_db() async {
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
    var flag = true;
    StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .orderBy("id")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final sessionDataList = snapshot.data;
            final docs = snapshot.data!.docs
                .map((doc) => doc.get("phone") == userjson["phone"]
                    ? flag = true
                    : flag = flag)
                .toList();
            return flag == true ? Text("Ok") : Text("Not Ok");
          }
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
    if (!flag) {
      await FirebaseFirestore.instance.collection('users').doc().set(userjson);
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
                      register_to_db();
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
