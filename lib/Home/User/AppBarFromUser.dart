import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled7/Home/Admin/HomeAdmin.dart';
import 'package:untitled7/Home/Admin/NewSubject.dart';
import 'package:untitled7/Home/Admin/NewUser.dart';
import 'package:untitled7/Home/Admin/ShowUserSubject.dart';
import 'package:untitled7/Home/Admin/AddSubjecttoUser.dart';
import 'package:untitled7/Home/Chat/Admin/ChatAdmin.dart';
import 'package:untitled7/Home/Chat/User/ChatUser.dart';
import 'package:untitled7/Home/User/HomeUser.dart';
import 'package:untitled7/main.dart';

import '../../Class/GetxController.dart';
import '../../Class/UserController.dart';

class AppBarFromUser extends StatefulWidget {
  const AppBarFromUser({Key? key}) : super(key: key);

  @override
  _AppBarFromUserState createState() => _AppBarFromUserState();
}

final HomeController controller = Get.put(HomeController());
final UserController _UserController = Get.put(UserController());

class _AppBarFromUserState extends State<AppBarFromUser> {
  late int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    HomeUser(),
    ChatUser(),
  ];

  void _onItemTapped1(int index) {
    setState(() {
      _selectedIndex = index;
      _UserController.fetchDataUserList(sharedPreferences.getString("id").toString());
    });
  }

  @override
  void initState() {
    super.initState();
    controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Subject',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: (value) {
          setState(() {
            print(value);
            _onItemTapped1(value);
          });
        },
      ),
    );
  }
}
