import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Class/crud.dart';
import '../Home/Admin/ShowUserSubject.dart';
import '../Home/Admin/AppBarFromAdmin.dart';
import '../link/link.dart';

Crud _crud = Crud();
ReseveidUser(String NameUser, BuildContext context) async {
  var response = await _crud.postRequest(LinkreseveIduser, {
    'username': NameUser,
  });

  if (response != null && response is Map<String, dynamic>) {
    if (response['status'] == 's') {
      var userId = response['data']['id'];
      IdUser = userId.toString();
      print("User ID: $userId");

      var userResponse = await _crud.postRequest(LinkShowUserSubject, {
        'user_id': userId.toString(),
      });

      if (userResponse != null && userResponse is List<dynamic>) {
        response1 = List<Map<String, dynamic>>.from(userResponse);
        print(response1);
        subjectIds = response1.map((e) => e['subject_id'].toString()).toList();
        print(subjectIds.join(", "));
      } else {
        AwesomeDialog(
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          btnOkColor: Colors.black,
          btnCancelColor: Colors.red,
          title: 'Show Subject Error',
          desc:
          'This User have not subject',
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppBarScreen(),));
          },
          context: context,
        ).show();
      }
    } else {
      throw Exception('Failed to activate user');
    }
  } else {
    throw Exception('Invalid response received from the server');
  }
}
Future<List<String>> fetchSubjects(List<String> subjectIds) async {
  var response = await _crud.postRequest(LinkreturnSubject, {
    'subject_ids': subjectIds.join(","),
  });
  if (response != null && response['status'] == 's') {
    List<Map<String, dynamic>> data =
    List<Map<String, dynamic>>.from(response['data']);
    return data.map((e) => e['subject'] as String).toList();
  } else {
    throw Exception('Failed to fetch subjects');
  }
}
sendMark(String username, String subjectId, String mark, BuildContext context) async {
  var response = await _crud.postRequest(LinkSendMark, {
    'user_id': username,
    'subject_id': subjectId,
    'mark': mark,
  });

  if (response != null ) {
    if (response['status'] == 's') {
      print('Mark sent successfully.');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppBarScreen(),));
    } else {
      print('Failed to send mark.');
    }
  } else {
    print('No response received from the server.');
  }
}
Future<List<String>> fetchUsernames() async {

  var response = await _crud.getRequest(Linkreturnuser);

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    List<String> usernames = [];

    if (data['status'] == 's') {
      List<dynamic> userList = data['data'];
      userList.forEach((user) {
        usernames.add(user['username']);
      });
    }
    return usernames;
  } else {
    throw Exception('Failed to load data');
  }
}
