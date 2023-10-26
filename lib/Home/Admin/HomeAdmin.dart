import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled7/Home/Admin/AppBarFromAdmin.dart';
import 'package:untitled7/auth/Singup.dart';
import '../../Class/GetxController.dart';
import '../../Constant/Allcolor.dart';
import '../../FunctionDatabase/functionHomeadmin.dart';
import '../../Widget/TextForm.dart';
import '../../link/validators.dart';
import '../../main.dart';
final HomeController controller = Get.put(HomeController());


class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({Key? key}) : super(key: key);

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  late bool isActivated;
  FormValidator _validator = FormValidator();

  void editUser(int index) {
    String newUsername = controller.data[index]['username'];
    String newEmail = controller.data[index]['email'];
    final TextEditingController emailController = TextEditingController();
    final TextEditingController usernameConroller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: background,
          title: Text(
            'Information \n UserName : ${controller.data[index]['username']} \n Email : ${controller.data[index]['email']}',
            style: TextStyle(color: white, fontSize: 15),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Textform(
                usernameConroller,
                'New Username',
                (value) => _validator.validateUsername,
              ),
              SizedBox(
                height: 20,
              ),
              Textform(
                emailController,
                'New email',
                (value) => _validator.validateEmail,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_validator.validateUsername(usernameConroller.text) ==
                        null &&
                    _validator.validateEmail(emailController.text) == null) {
                  updateUser(controller.data[index]['id'].toString(),
                      usernameConroller.text, emailController.text);
                  controller.update();
                  controller.fetchData();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppBarScreen(),));
                } else {
                  print("not valid");
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void deleteUser(int index, BuildContext context) {
    String usernameid = controller.data[index]['id'].toString();
    AwesomeDialog(
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      btnOkColor: Colors.black,
      btnCancelColor: Colors.red,
      title: 'Delete ${controller.data[index]['username']}',
      desc: 'Confirm the deletion',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
       setState(() {
         DeleteUser(usernameid,context,index);
       });
      },
      context: context,
    ).show();
  }

  void ActivationUser(int index) {
    String usernameid = controller.data[index]['id'].toString();

    AwesomeDialog(
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      btnOkColor: Colors.black,
      btnCancelColor: Colors.red,
      title: 'Activation ${controller.data[index]['username']}',
      desc: 'Confirm the Activation',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        activateUser(usernameid);
        controller.update();
        controller.fetchData();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppBarScreen(),));
      },
      context: context,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            String s =  sharedPreferences.getString("id").toString();
            print(s);
            sharedPreferences.clear();

            Get.off(() => SingUpPage());
          },
          icon: Icon(Icons.login_outlined),
        ),
        title: const Text('Admin page'),
      ),
      body: Obx(() => ListView.builder(
          shrinkWrap: true,
          itemCount: controller.data.length,
          itemBuilder: (context, index) {
            isActivated = controller.data[index]['activation'] == 1;
            return ListTile(
              title: Text(
                  style: TextStyle(color: Colors.white),
                  'Username: ${controller.data[index]['username']}'),
              subtitle: Text(
                  style: TextStyle(color: Colors.white),
                  'Email:${controller.data[index]['email']}, activation${controller.data[index]['activation']}'),
              trailing: DropdownButton<String>(
                style: TextStyle(color: Colors.white),
                isDense: true,
                value: controller.selectedValue.value,
                items: const [
                  DropdownMenuItem(
                    child: Text(
                      'Edit',
                      style: TextStyle(color: primecolor),
                    ),
                    value: 'Edit',
                  ),
                  DropdownMenuItem(
                    child: Text('Delete', style: TextStyle(color: primecolor)),
                    value: 'Delete',
                  ),
                  DropdownMenuItem(
                    child: Text('Activa', style: TextStyle(color: primecolor)),
                    value: 'Activation',
                  ),
                ],
                onChanged: (String? value) {
                  controller.onItemSelected(value);
                  if (value == 'Edit') {
                    editUser(index);
                  } else if (value == 'Delete') {
                    deleteUser(index, context);
                  } else if (value == 'Activation') {
                    ActivationUser(index);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
