import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled7/Constant/Allcolor.dart';
import 'package:untitled7/Home/Admin/AppBarFromAdmin.dart';
import 'package:untitled7/Home/User/AppBarFromUser.dart';
import 'package:untitled7/Home/User/HomeUser.dart';
import 'package:untitled7/auth/Singup.dart';
import 'package:untitled7/Home/Admin/HomeAdmin.dart';

import 'Home/Chat/Admin/ChatAdmin.dart';
import 'auth/Login.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: background
        )
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: sharedPreferences.getString("id") == null
          ? "signup"
          : sharedPreferences.getString("admin") == "1"
          ? "appbarfromadmin"
          : "appbarfromuser",
      routes: {
        "login": (context) => Loginpage(),
        "signup": (context) => SingUpPage(),
        "home": (context) => HomePageAdmin(),
        "appbarfromadmin": (context) => AppBarScreen(),
        "chatadmin":(context) => ChatAdmin(),
        "homeuser":(context) => HomeUser(),
        "appbarfromuser":(context) => AppBarFromUser(),
      },
    );
  }
}
