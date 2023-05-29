import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:bakery_project/services/controller.dart';
import 'package:bakery_project/pages/admin_additem.dart';
import 'package:bakery_project/pages/home.dart';
import 'package:bakery_project/pages/login.dart';
import 'package:bakery_project/pages/main.dart';
import 'package:bakery_project/pages/signup.dart';
import 'package:bakery_project/pages/users.dart';
import 'package:bakery_project/pages/cart.dart';
import 'package:bakery_project/pages/orders.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  Get.testMode = true;
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final box = GetStorage();
  Controller ctrl = new Controller();


  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: (ctrl.IsLoggedIn() == true)?'/home':'/login',
    routes: {
      '/home': (context) => Home(),
      '/login': (context) => Login(),
      '/signup': (context) => SignUp(),
      '/mainPage': (context) => MainPage(),
      '/addItem': (context) => AddItem(),
      '/cart': (context) => Cart(),
      '/users': (context) => Users(),
      '/orders': (context) => Orders(),
    },
  ));
}