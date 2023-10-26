import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled7/Constant/Allcolor.dart';

import '../link/validators.dart';

class Textform extends StatelessWidget {
  final TextEditingController usernameController;
  final String labelText;
  final Function(String) validateTextname;
  final IconData? iconData;

  Textform(
      this.usernameController,
      this.labelText,
      this.validateTextname, {
        this.iconData,
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: usernameController,
      style: const TextStyle(color: Colors.white),
      validator: (value) => validateTextname(value!),
      decoration: InputDecoration(
        prefixIcon: iconData != null ? Icon(iconData, color: primecolor) : Icon(Icons.abc, color: primecolor),
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
