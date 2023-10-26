import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled7/Home/Admin/AppBarFromAdmin.dart';
import '../../Constant/Allcolor.dart';
import 'package:untitled7/Widget/Textform.dart';
import '../../Class/crud.dart';
import '../../Static/SizeBox.dart';
import '../../Widget/TextFormNumber.dart';
import '../../link/ValidationSubject.dart';
import '../../link/link.dart';

class NewSubject extends StatelessWidget {
  NewSubject({Key? key}) : super(key: key);
  final TextEditingController subjectname = TextEditingController();
  final TextEditingController minmark = TextEditingController();
  var context1;
  GlobalKey<FormState> formstate = GlobalKey();
  Crud _crud = Crud();
  FormValidatorSubject _validator = FormValidatorSubject();

  newsubject() async {
    if (formstate.currentState!.validate()) {
      try {
        var response = await _crud.postRequest(LinkSubject, {
          "subject": subjectname.text,
          "mark": minmark.text,
        });

        if (response['status'] == "s") {
          AwesomeDialog(
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            btnOkColor: Colors.black,
            title: 'add Subject Done',
            btnOkOnPress: () {
             Navigator.pushReplacement(context1, MaterialPageRoute(builder: (context) => AppBarScreen(),));
             },
            context: context1,
          ).show();
        } else {
          print("Status is not 's' or response is invalid");
        }
      } catch (e) {
        print("Error occurred: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    context1 = context;
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text("New Subject"),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: InkWell(
        onTap: () async {
          await newsubject();
        },
        child: Container(
          alignment: Alignment.center,
          height: 80,
          width: 80,
          decoration: const BoxDecoration(
            color: primecolor,
            shape: BoxShape.circle,
          ),
          child: const Text(
            "add",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Container(
              width: 250,height: 250,
              child: Image(image: AssetImage("images/page1/NewSub.png")),),
            Padding(
              padding: const EdgeInsets.only(top: 50 , left: 20,right: 20),
              child: Form(
                key: formstate,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

                  Textform(subjectname, "Subject", _validator.validateSubject,
                      iconData: Icons.bookmark_add),
                  sizeBox(),
                  TextformNumber(minmark, "Mark", _validator.validateEMark),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
