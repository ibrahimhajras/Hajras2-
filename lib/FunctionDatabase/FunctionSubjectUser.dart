import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Class/crud.dart';
import '../Home/Admin/AppBarFromAdmin.dart';
import '../link/link.dart';

Resevedata(String NameUser, String NameSubject, BuildContext context) async {
  Crud _crud = Crud();
  var response = await _crud.postRequest(LinkReseveData, {
    'username': NameUser,
    'subject': NameSubject,
  });
  if (response != null) {
    if (response['status'] == 's') {
      var userId = response['id'];
      var subjectId = response['subject_id'];
      print("User ID: $userId");
      print("Subject ID: $subjectId");
      var response1 = await _crud.postRequest(LinkadSubjectUser, {
        'user_id': userId.toString(),
        'subject_id': subjectId.toString(),
      });
      if (response1 != null && response1['status'] == 's') {
        AwesomeDialog(
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          btnOkColor: Colors.black,
          title: 'add Subject to User Done',
          btnOkOnPress: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppBarScreen(),));
          },
          context: context,
        ).show();
      } else {
        return "Failed to activate user!";
      }
    } else {
      return "Failed to activate user!";
    }
  } else {
    throw Exception('Failed to activate user');
  }
}
