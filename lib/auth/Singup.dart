import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled7/auth/Login.dart';
import '../Class/crud.dart';
import '../Constant/Allcolor.dart';
import '../Constant/ImageAsset.dart';
import '../Static/SizeBox.dart';
import '../Widget/Textform.dart';
import '../link/link.dart';
import '../link/validators.dart';
import '../main.dart';

class SingUpPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  Crud _crud = Crud();

  singUp() async {
    if (formstate.currentState!.validate()) {
      try {
        var response = await _crud.postRequest(LinkSingup, {
          "username": usernameController.text,
          "email": emailController.text,
          "password": passwordController.text,
        });

        if (response['status'] == "s") {
          Get.to(() => Loginpage());
        } else {
          print("Status is not 's' or response is invalid");
        }
      } catch (e) {
        print("Error occurred: $e");
      }
    }
  }

  FormValidator _validator = FormValidator();

  SingUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      resizeToAvoidBottomInset: false,
      floatingActionButton: InkWell(
        onTap: () async {
          await singUp();
        },
        child: Container(
          alignment: Alignment.center,
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: primecolor,
            shape: BoxShape.circle,
          ),
          child: const Text(
            "signup",
            style: TextStyle(color: white),
          ),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: background,
      ),
      body: Column(
        children: [
          Container(
              width: 200, child: Image(image: AssetImage(ImageAsset.SingUp1))),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formstate,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Textform(usernameController, "Username",
                      _validator.validateUsername, iconData:Icons.person),
                  sizeBox(),
                  Textform(emailController, "Email", _validator.validateEmail,
                      iconData: Icons.email),
                  sizeBox(),
                  Textform(passwordController, "Password",
                      _validator.validatePassword, iconData:Icons.password),
                  sizeBox(),
                  Textform(repeatPasswordController, "Repeat Password",
                      _validator.validatePasswordAndRepeat, iconData:Icons.password),
                  sizeBox(),
                  Container(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Get.to(() => Loginpage());
                      },
                      child: const Text(
                        "i have account [Login]",
                        style: TextStyle(color: white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
