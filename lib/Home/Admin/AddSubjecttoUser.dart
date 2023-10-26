import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled7/Constant/Allcolor.dart';
import '../../Constant/ImageAsset.dart';
import '../../Class/GetxController.dart';
import '../../FunctionDatabase/FunctionSubjectUser.dart';

class AddSubjectUser extends StatefulWidget {
  AddSubjectUser({Key? key}) : super(key: key);

  @override
  _AddSubjectUserState createState() => _AddSubjectUserState();
}

final HomeController controller = Get.put(HomeController());
final SubjectUserController subjectController =
    Get.put(SubjectUserController());
final TextEditingController minmark = TextEditingController();

class _AddSubjectUserState extends State<AddSubjectUser> {
  String? selectedValueUserName;
  String? selectedValueSubject;



  late String valueName = "User";
  late String valueIdsubjectl ="Subject";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('new Subject to User'),
      ),
      body: Obx(() =>Column(
        children: [
          Container(
              width: 250,height: 250,
              child: Image(image: AssetImage(ImageAsset.page3))),
            DropdownButton<String>(
              style: TextStyle(color: primecolor),
              alignment: Alignment.center,
              value: selectedValueUserName,
              hint: Text('$valueName', style: TextStyle(color: white)),
              items: controller.data.map((e) {
                return DropdownMenuItem<String>(
                  value: e['username'].toString(),
                  child: Text(e['username'].toString()),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    selectedValueUserName = value;
                    valueName = value;
                    print(valueName);
                  });
                }
              },
            ),
          const Divider(
            thickness: 5,
            endIndent: 5,
            indent: 5,
            color: Colors.black54,
          ),
          DropdownButton<String>(
            style: TextStyle(color: primecolor),
            alignment: Alignment.center,
            value: selectedValueSubject,
            hint: Text('$valueIdsubjectl', style: TextStyle(color: white)),
            items: subjectController.data1.map((e) {
              return DropdownMenuItem<String>(
                value: e['subject'].toString(),
                child: Text(e['subject'].toString()),
              );
            }).toList(),
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  selectedValueSubject = value;
                  valueIdsubjectl = value.toString();
                  print(valueIdsubjectl);
                });
              }
            },
          ),
          const Divider(
            thickness: 5,
            endIndent: 5,
            indent: 5,
            color: Colors.black54,
          ),
          ElevatedButton(
            onPressed: () {
              print(selectedValueUserName);
              print(selectedValueSubject);
              Resevedata(selectedValueUserName.toString(),
                  selectedValueSubject.toString(),context);
            },
            child: const Text("Add"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(primecolor),
            ),
          ),
        ],
      )),
    );
  }
}
