import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled7/Home/Admin/HomeAdmin.dart';
import 'package:untitled7/Home/Admin/NewSubject.dart';
import 'package:untitled7/Home/Admin/NewUser.dart';
import 'package:untitled7/Home/Admin/ShowUserSubject.dart';
import 'package:untitled7/Home/Admin/AddSubjecttoUser.dart';
import 'package:untitled7/Home/Chat/Admin/ChatAdmin.dart';

import '../../Class/GetxController.dart';

class AppBarScreen extends StatefulWidget {
  const AppBarScreen({Key? key}) : super(key: key);

  @override
  _AppBarScreenState createState() => _AppBarScreenState();
}

final HomeController controller = Get.put(HomeController());

class _AppBarScreenState extends State<AppBarScreen> {
  late int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomePageAdmin(),
    NewUser(),
    NewSubject(),
    ChatAdmin(),
    AddSubjectUser(),
    ShowUserSubject(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      controller.update();
      controller.fetchData();
    });
  }

  @override
  void initState() {
    super.initState();
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'NewUser',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_add),
            label: 'NewSubject',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_to_drive_sharp),
            label: 'AddSubject',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'ShowSubject',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: (value) {
          setState(() {
            print(value);
            _onItemTapped(value);
          });
        },
      ),
    );
  }
}
