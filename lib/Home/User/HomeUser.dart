import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Class/crud.dart';
import '../../Constant/Allcolor.dart';
import '../../auth/Singup.dart';
import '../../link/link.dart';
import '../../main.dart';

class HomeUser extends StatefulWidget {
  HomeUser({Key? key}) : super(key: key);

  @override
  _HomeUserState createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  Crud _crud = Crud();
  List<dynamic> subjects = [];

  @override
  void initState() {
    super.initState();
    fetchUserSubjects();
  }

  void fetchUserSubjects() async {
    try {
      var response = await _crud.postRequest(LinkreseveSubject, {'user_id': '103'});
      print(response);
      if (response is List) {
        var data = json.decode(json.encode(response));
        if (data is List) {
          setState(() {
            subjects = List.from(data);
          });
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            sharedPreferences.clear();
            Get.off(() => SingUpPage());
          },
          icon: Icon(Icons.login_outlined),
        ),
        title: const Text('User page'),
        actions: [
          IconButton(
            onPressed: () {
           //   Navigator.push(context, MaterialPageRoute(builder: (context) => ChatUser()));
            },
            icon: Icon(Icons.chat,color: primecolor),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title:
                Text(
                  "${subjects[index]['subject']}",
                  style: TextStyle(color: Colors.white),
                ),
                trailing:
                Text(
                  "Mark: ${subjects[index]['mark']}",
                  style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
