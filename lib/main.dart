import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:owanto_app/src/const/app_colors.dart';
import 'package:owanto_app/src/const/globals.dart';
import 'package:owanto_app/src/data/service/product_service.dart';
import 'package:owanto_app/src/data/service/users_services.dart';
import 'package:owanto_app/src/router/router.dart';
import 'package:owanto_app/src/view/screen/dash_board_screen.dart';
import 'package:owanto_app/src/view/screen/login_screen.dart';
import 'package:owanto_app/src/viewmodel/address_viewmodel.dart';
import 'package:owanto_app/src/viewmodel/auth_viemodel.dart';
import 'package:owanto_app/src/viewmodel/bottom_navigate_provider.dart';
import 'package:owanto_app/src/viewmodel/cart_viewmodel.dart';
import 'package:owanto_app/src/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() {
  runApp(MyApp());
}

void start_firebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

UserService userservice = UserService();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Future<bool> is_first_log_in() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedToken = prefs.getString('userToken');
    String? savedPassword = prefs.getString('userPass');
    CartViewModel cart = new CartViewModel();

    if (savedToken != null && savedToken.isNotEmpty) {
      try {
        // Authenticate the user using the saved token
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCustomToken(savedToken);
        AuthCredential credential = userCredential.credential as AuthCredential;
        UserCredential sign_in_with_token =
            await FirebaseAuth.instance.signInWithCredential(credential);
        String string_credential = sign_in_with_token.credential.toString();
        // Access user account and perform necessary operations
        setCurrentUser(userCredential);
        return true;
      } catch (e) {
        print('Accessing user with token failed: $e');
      }
    } else {
      print('No saved user token found');
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    start_firebase();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => AddressViewModel()),
        ChangeNotifierProvider(
            create: (_) => ProductViewModel()..getListProduct()),
        ChangeNotifierProvider(
            create: (_) => ProductService()..getListdicountProduct()),
        ChangeNotifierProvider(create: (_) => AuthViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: buildMaterialColor(Colors.cyan.shade800),
          primaryColor: Colors.black,
        ),
        onGenerateRoute: Routes.onGenerateRouter,
        home: FutureBuilder<bool?>(
          future: is_first_log_in(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final bool? logged_in = snapshot.data as bool;
              return (logged_in == true) ? DashBoardScreen() : LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
