import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled7/Constant/Allcolor.dart';

import '../link/validators.dart';

class TextformNumber extends StatelessWidget {
  final TextEditingController usernameController;
  final String labelText;
  final FormValidator _validator = FormValidator();
  final Function(String) validateTextname;
  TextformNumber(this.usernameController, this.labelText,this.validateTextname,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: usernameController,
      style: const TextStyle(color: Colors.white),
      validator: (value) => validateTextname(value!),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.abc,color: primecolor),
        hintText: labelText,
        hintStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}