import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Class/GetxController.dart';
import '../Home/Admin/AppBarFromAdmin.dart';

class SwitchButton extends StatefulWidget {
  final bool isActivated;

  const SwitchButton({required this.isActivated, Key? key}) : super(key: key);

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  late bool light;
  @override
  void initState() {
    super.initState();
    light = widget.isActivated;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          light = !light;
        });
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: light ? Colors.blue : Colors.red,
        ),
      ),
    );
  }
}
