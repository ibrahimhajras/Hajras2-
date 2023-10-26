import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled7/Home/Admin/AppBarFromAdmin.dart';
import 'package:untitled7/Widget/TextForm.dart';
import '../Class/crud.dart';
import '../Constant/Allcolor.dart';
import '../Constant/ImageAsset.dart';
import '../Home/User/AppBarFromUser.dart';
import '../Home/User/HomeUser.dart';
import '../link/link.dart';
import '../link/validators.dart';
import '../main.dart';

class Loginpage extends StatelessWidget {
  Loginpage({Key? key}) : super(key: key);
  Login(BuildContext context) async {
    try {
      var response = await _crud.postRequest(LinkLogin, {
        "email": emailController.text,
        "password": passwordController.text,
      });
      if (response['status'] == "s") {
        if (response['data']['admin'] == 1) {
          sharedPreferences.setString("id", response['data']['id'].toString());
          sharedPreferences.setString("email", response['data']['email']);
          sharedPreferences.setString("password", response['data']['password']);
          sharedPreferences.setString("admin", response['data']['admin'].toString());
            Get.offAll(()=>AppBarScreen());

        } else if(response['data']['admin'] == 0){
          sharedPreferences.setString("id", response['data']['id'].toString());
          sharedPreferences.setString("email", response['data']['email']);
          sharedPreferences.setString("password", response['data']['password']);
          sharedPreferences.setString("admin", response['data']['admin'].toString());
          Get.offAll(()=>AppBarFromUser());
        }
      }
    } catch (e) {
      print("errrrrrrrrrror $e");
    }
  }


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Crud _crud = Crud();
  FormValidator v = FormValidator();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: InkWell(
          onTap: () async {
            await Login(context);
          },
          child: Container(
            alignment: Alignment.center,
            height: 80,
            width: 80,
            decoration: const BoxDecoration(
              color: primecolor,
              shape: BoxShape.circle,
            ),
            child: Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text('Login'),
          backgroundColor: background,
        ),
        backgroundColor: background,
        resizeToAvoidBottomInset: false,
        drawerEnableOpenDragGesture: false,
        body: Column(
          children: [
            Container(
                width: 225,
                child:  Image(image: AssetImage(ImageAsset.Login))
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Textform(emailController, 'Email', v.validateEmail),
                    SizedBox(height: 20),
                    Textform(passwordController, 'Password', v.validatePassword),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
