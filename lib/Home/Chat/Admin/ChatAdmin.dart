import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled7/Constant/Allcolor.dart';
import '../../../Class/GetxController.dart';
import '../../../Constant/ImageAsset.dart';
import 'PrivateChatPage.dart';


class ChatAdmin extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: background,
        appBar: AppBar(
          title: const Text("Chat Page"),
          backgroundColor: background,
        ),
        body: GetBuilder<HomeController>(
          init: controller,
          builder: (controller) {
            return ListView.separated(
              padding: const EdgeInsets.only(top: 20),
              itemCount: controller.data.length,
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(color: Colors.white, height: 6),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    title: Text(
                      controller.data[index]['username'],
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateChatPage(index),));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

