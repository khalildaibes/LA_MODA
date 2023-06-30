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
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('users');

    _collectionRef.add(userjson);
  }

  // void getToken() async {
//     await FirebaseMessaging.instance.getToken().then((token) {
//       mtoken = token;
//       saveToken(token);
//     });
//   }
//   UserCredential userCredentialFromString(String userCredentialString) {
//   final lines = userCredentialString.split('\n');

//   final user = User(
//     uid: getValue(lines[2]),
//     email: getValue(lines[3]),
//     phoneNumber: getValue(lines[4]),
//     displayName: getValue(lines[5]),
//     photoURL: getValue(lines[6]),
//     providerId: getValue(lines[7]),
//   );

//   final additionalUserInfo = AdditionalUserInfo(
//     providerId: getValue(lines[10]),
//     username: getValue(lines[11]),
//     // Add more properties as needed
//   );

//   return UserCredential(user: user, additionalUserInfo: additionalUserInfo);
// }

  String getValue(String line) {
    return line.substring(line.indexOf(':') + 1).trim();
  }

  String userCredentialToString(UserCredential userCredential) {
    if (userCredential == null) return '';

    User? user = userCredential.user;
    final additionalUserInfo = userCredential.additionalUserInfo;

    final buffer = StringBuffer();
    buffer.writeln('UserCredential:');
    buffer.writeln('  User:');
    buffer.writeln('    UID: ${user!.uid}');
    buffer.writeln('    Email: ${user!.email}');
    buffer.writeln('    Phone Number: ${user!.phoneNumber}');
    buffer.writeln('    Display Name: ${user!.displayName}');
    buffer.writeln('    Photo URL: ${user!.photoURL}');
    buffer.writeln('    Provider ID: ${userCredential.credential!.providerId}');
    buffer.writeln('  Additional User Info:');
    buffer.writeln('    Provider ID: ${additionalUserInfo!.providerId}');
    buffer.writeln('    Username: ${additionalUserInfo!.username}');
    // Add more properties as needed

    return buffer.toString();
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

  Future<bool> login(pass, uncoded_phone, name, context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    String phone = "+972" + uncoded_phone.toString().substring(1);
    print(phone);

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userToken', credential.token.toString());
        Navigator.pushNamed(context, DashBoardScreens);
        //This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (FirebaseAuthException exception) {
        print(exception);
      },
      codeSent: (String verificationId, [int? forceResendingToken]) {
        showDialog(
            context: context,
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
                                register_to_db(
                                    name, pass, uncoded_phone.toString());
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                isLoggedIn = true;
                                Navigator.pushNamed(context, DashBoardScreens);
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
