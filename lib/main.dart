// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart' hide Badge;
import 'package:owanto_app/src/const/app_colors.dart';
import 'package:owanto_app/src/data/service/product_service.dart';
import 'package:owanto_app/src/router/router.dart';
import 'package:owanto_app/src/view/screen/login_screen.dart';
import 'package:owanto_app/src/viewmodel/address_viewmodel.dart';
import 'package:owanto_app/src/viewmodel/auth_viemodel.dart';
import 'package:owanto_app/src/viewmodel/bottom_navigate_provider.dart';
import 'package:owanto_app/src/viewmodel/cart_viewmodel.dart';
import 'package:owanto_app/src/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(MyApp());
}

void start_firebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        home: LoginScreen(),
      ),
    );
  }
}
