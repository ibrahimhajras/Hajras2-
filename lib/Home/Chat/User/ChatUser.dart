import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled7/Class/UserController.dart';
import 'package:untitled7/Constant/Allcolor.dart';
import 'package:untitled7/Home/Chat/Admin/PrivateChatPage.dart';
import 'package:untitled7/Home/Chat/User/PrivateChatUser.dart';
import '../../../Constant/ImageAsset.dart';
import '../../../main.dart';

class ChatUser extends StatefulWidget {
  ChatUser({Key? key}) : super(key: key);
   @override
  State<ChatUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<ChatUser> {
  UserController _userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    _userController.fetchDataUserList(sharedPreferences.getString("id").toString());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      appBar: AppBar(
        title: const Text("Chat Page"),
        backgroundColor: background,
      ),
      body: GetBuilder<UserController>(
        init: _userController,
        builder: (controller) {
          return ListView.separated(
            padding: const EdgeInsets.only(top: 20),
            itemCount: controller.dataList.length,
            separatorBuilder: (BuildContext context, int index) =>
            const Divider(color: Colors.white, height: 6),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  title: Text(
                    controller.dataList[index]['username'],
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  trailing: const Icon(
                    Icons.chat,
                    color: primecolor,
                  ),
                  leading: const Image(
                    image: AssetImage(ImageAsset.chat),
                    width: 30,
                    color: primecolor,
                  ),
                  onTap: () {
                    print(index);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateChatUser(index),));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
