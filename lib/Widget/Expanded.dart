import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Expaneded extends StatefulWidget {
  late List<String> list;
  String? selectedValue;
  late int i;
  late String name;

  Expaneded(this.list, this.selectedValue, this.i, this.name, {Key? key})
      : super(key: key);

  @override
  State<Expaneded> createState() => _ExpanededState();
}

class _ExpanededState extends State<Expaneded> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.i,
      child: Container(
        alignment: Alignment.center,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              '${widget.name}',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: widget.list
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ))
                .toList(),
            value: widget.selectedValue,
            onChanged: (String? value) {
              setState(() {
                widget.selectedValue = value;

              });
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 140,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
        ),
      ),
    );
  }
}
