import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/app_font.dart';
import '../const/globals.dart';
import '../router/router_path.dart';

class AuthViewModel extends ChangeNotifier {
  bool isLoggedIn = false;
  bool isLoading = false;
  String? mtoken = "";
  final _codeController = TextEditingController();
  bool _remember_me = false;

  void register_to_db(name, pass, phone) async {
    const deatils = {
      "nane": "0",
      "phone": "0",
      "password": "0",
    };
    Map<String, dynamic> userjson = {
      "name": name,
      "phone": phone,
      "password": pass,
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
            print("here1");
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
    if (!flag) {
      await FirebaseFirestore.instance.collection('users').doc().set(userjson);
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      mtoken = token;
      saveToken(token);
    });
  }

  void saveToken(String? token) async {
    await FirebaseFirestore.instance
        .collection("UsersToken")
        .doc(getCurrentUser()!.uid.toString())
        .set({
      'token': token,
    });
    print("ok");
  }

  Future<bool> login(pass, phone, name, contxt) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    phone = "+972" + phone.toString().substring(1);
    print(phone);

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        UserCredential result = await _auth.signInWithCredential(credential);

        User? user = result.user;

        if (user != null) {
          await setCurrentUser(user);
          if (result.additionalUserInfo!.isNewUser == true) {
            register_to_db(name, pass, phone);
          }
          if (_remember_me) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('uid', result.user!.uid);
          }
          getToken();

          Navigator.pushReplacementNamed(contxt, DashBoardScreens);

          print("here1");
        } else {
          print("Error");
        }

        //This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (FirebaseAuthException exception) {
        print(exception);
      },
      codeSent: (String verificationId, [int? forceResendingToken]) {
        showDialog(
            context: contxt,
            barrierDismissible: false,
            builder: (context) {
              return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    backgroundColor: Color.fromARGB(255, 231, 153, 243),
                    title: Text("الرجاء ادخال الرمز المكون من ٦ ارقام"),
                    content: Column(
                      textDirection: TextDirection.rtl,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: 80,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _codeController,
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      Container(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 236, 206, 234),
                          )),
                          child: Text("تاكيد",
                              style:
                                  AppFont.bold.copyWith(color: Colors.black)),
                          onPressed: () async {
                            try {
                              if (_codeController == "" ||
                                  _codeController == null) {
                                throw Exception("no code");
                              }
                              final code = _codeController.text.trim();
                              AuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationId,
                                      smsCode: code);

                              UserCredential result =
                                  await _auth.signInWithCredential(credential);

                              User? user = result.user;

                              if (user != null) {
                                isLoggedIn = true;
                                setCurrentUser(result);
                                if (result.additionalUserInfo!.isNewUser ==
                                    true) {
                                  register_to_db(name, pass, phone);
                                }
                                Navigator.pushReplacementNamed(
                                    context, DashBoardScreens);
                              } else {
                                print("Error");
                              }
                            } catch (e) {
                              print(e);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Colors.transparent,
                                behavior: SnackBarBehavior.floating,
                                elevation: 0,
                                content: Stack(
                                  alignment: Alignment.center,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      height: 70,
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 48,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  'خطا!!',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  'خطا في تاكيد الرمز',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 25,
                                        left: 20,
                                        child: ClipRRect(
                                          child: Stack(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.red.shade200,
                                                size: 17,
                                              )
                                            ],
                                          ),
                                        )),
                                    Positioned(
                                        top: -20,
                                        left: 5,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                              ),
                                            ),
                                            const Positioned(
                                                top: 5,
                                                child: Icon(
                                                  Icons.clear_outlined,
                                                  color: Colors.white,
                                                  size: 20,
                                                ))
                                          ],
                                        )),
                                  ],
                                ),
                              ));
                            }
                          },
                        ),
                      )
                    ],
                  ));
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    if (isLoggedIn) {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
