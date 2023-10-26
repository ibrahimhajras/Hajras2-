import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled7/Constant/Allcolor.dart';
import '../../Constant/ImageAsset.dart';
import '../../Class/GetxController.dart';
import '../../FunctionDatabase/FunctionShowUser.dart';
import '../../Widget/TextFormNumber.dart';
import '../../link/ValidationSubject.dart';

class ShowUserSubject extends StatefulWidget {
  const ShowUserSubject({Key? key}) : super(key: key);

  @override
  State<ShowUserSubject> createState() => _ShowUserSubjectState();
}
final HomeController controller = Get.put(HomeController());
FormValidatorSubject _validator = FormValidatorSubject();
List<Map<String, dynamic>> response1 = [];
List<String> subjectIds = [];
List<String> subjectNames = [];
late String IdUser;


class _ShowUserSubjectState extends State<ShowUserSubject> {
  late String valueName = "User";
  late String valueIdsubjectl ="Subject";
  final TextEditingController minmark = TextEditingController();


  @override
  Widget build(BuildContext context) {
    String? selectedValueUserName;
    String? selectedValueSubject;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Show subject'),
      ),
      body: Obx(() =>Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: 190,
              child: Image(image: AssetImage(ImageAsset.page4))),
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
              setState(() {
                selectedValueUserName = value;
                valueName = value ?? "User"; // Set a default value if value is null
                print(valueName);
              });
            },
          ),

          ElevatedButton(
            onPressed: () async {
              await ReseveidUser(valueName , context);
              subjectNames = await fetchSubjects(subjectIds);
              print(subjectNames);
              setState(() {});
            },
            style: ButtonStyle( backgroundColor: MaterialStateProperty.all<Color>(primecolor)),
            child: const Text("Show"),
          ),
          DropdownButton<String>(
            style: TextStyle(color: primecolor),
            hint: Text('$valueIdsubjectl', style: TextStyle(color: white)),
            value: selectedValueSubject,
            items: List<DropdownMenuItem<String>>.generate(
              subjectNames.length,
                  (index) {
                return DropdownMenuItem(
                  value: subjectIds[index],
                  child: Text("${subjectNames[index]}"),
                );
              },
            ),
            onChanged: (String? value) {
              setState(() {
                selectedValueSubject = value;
                valueIdsubjectl = value.toString();
                print(value);
              });
            },
          ),
          SizedBox(height: 15,),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextformNumber(minmark, "Mark", _validator.validateEMark)),
          ElevatedButton(onPressed: () {
            //sendMark(s, subjectId, mark)
           print("${minmark.text} and ${IdUser.toString()} and ${valueIdsubjectl}");
           sendMark(IdUser,valueIdsubjectl,minmark.text,context);
          },style: ButtonStyle( backgroundColor: MaterialStateProperty.all<Color>(primecolor)), child: Text("Send"))
        ],
      )),
    );
  }
}
