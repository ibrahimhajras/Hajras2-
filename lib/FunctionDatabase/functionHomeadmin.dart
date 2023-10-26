import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Class/GetxController.dart';
import '../Class/crud.dart';
import '../Home/Admin/HomeAdmin.dart';
import '../Home/Admin/AppBarFromAdmin.dart';
import '../link/link.dart';

Crud _crud = Crud();
final HomeController controller = Get.put(HomeController());

activateUser(String id) async {
  var response = await _crud.postRequest(Linkedit, {'id': id});

  if (response is Map<String, dynamic>) {
    if (response.containsKey('statusCode')) {
      if (response['statusCode'] == 200) {
        if (response.containsKey('body')) {
          Map<String, dynamic> data = response['body'];
          if (data['status'] == 's') {
            return "User activated successfully!";
          } else {
            return "Failed to activate user!";
          }
        }
      }
    }
  } else {
    throw Exception('Failed to activate user');
  }
}

DeleteUser(String id, BuildContext context, int index) async {
  try {
    var response = await _crud.postRequest(Linkdelete, {'id': id});
    if (response.containsKey('statusCode')) {
      if (response['statusCode'] == 200) {
        Map<String, dynamic> data = response['body'];
        if (data['status'] == 's') {
          controller.update();
          controller.fetchData();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppBarScreen(),));
        } else {
          return "Failed to delete user!";
        }
      }
    }
    return "Failed to delete user! Invalid status code.";
  } catch (e) {
    print("Error occurred while deleting user: $e");
    return "Failed to delete user! Error: $e";
  }
}

Future<String> updateUser(String id, String username, String email) async {
  try {
    var response = await _crud.postRequest(LinkEditUser, {
      'id': id,
      'username': username,
      'email': email,
    });
    if (response.containsKey('statusCode')) {
      if (response['statusCode'] == 200) {
        Map<String, dynamic> data = response['body'];
        if (data['status'] == 's') {

          return "User updated successfully!";
        } else {
          return "Failed to update user!";
        }
      }
    }
    return "Failed to update user! Invalid status code.";
  } catch (e) {
    print("Error occurred while updating user: $e");
    return "Failed to update user! Error: $e";
  }
}
