import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled7/Home/Admin/AppBarFromAdmin.dart';
import '../../Class/crud.dart';
import 'package:untitled7/Constant/Allcolor.dart';
import '../../Constant/ImageAsset.dart';
import '../../Static/SizeBox.dart';
import '../../Widget/TextForm.dart';
import '../../link/link.dart';
import '../../link/validators.dart';

class NewUser extends StatelessWidget {
  NewUser({Key? key}) : super(key: key);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();Crud _crud = Crud();
  FormValidator _validator = FormValidator();



  Newuser(BuildContext context) async {
    if (formstate.currentState!.validate()) {
      try {
        var response = await _crud.postRequest(LinkSingup, {
          "username": usernameController.text,
          "email": emailController.text,
          "password": passwordController.text,
        });

        if (response['status'] == "s") {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppBarScreen(),));
        } else {
          print("Status is not 's' or response is invalid");
        }
      } catch (e) {
        print("Error occurred: $e");
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        floatingActionButton: InkWell(
          onTap: () async {
            await Newuser(context);
          },
          child: Container(
            alignment: Alignment.center,
            height: 80,
            width: 80,
            decoration: const BoxDecoration(
              color: primecolor,
              shape: BoxShape.circle,
            ),
            child: const Text(
              "add",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          title: const Text('New User'),
          backgroundColor: background,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).padding.top,
              ),
              child: Column(
                children: [
                  Container(
                    width: 200,
                    child: Image(image: AssetImage(ImageAsset.SingUp1)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formstate,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Textform(usernameController, "Username",
                              _validator.validateUsername),
                          sizeBox(),
                          Textform(emailController, "Email",
                              _validator.validateEmail),
                          sizeBox(),
                          Textform(passwordController, "Password",
                              _validator.validatePassword),
                          sizeBox(),
                          Textform(
                            repeatPasswordController,
                            "Repeat Password",
                            _validator.validatePasswordAndRepeat,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

    );
  }

}
