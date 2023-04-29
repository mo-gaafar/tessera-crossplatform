import 'package:flutter/material.dart';

class MyDropDownMenu extends StatefulWidget {
  MyDropDownMenu({
    super.key,
    required this.myList,
  });

  final List<String> myList;

  @override
  State<MyDropDownMenu> createState() => _MyDropDownMenuState();
}

class _MyDropDownMenuState extends State<MyDropDownMenu> {
  late String selectedValue = widget.myList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedValue,
      onChanged: (value) {
        setState(() {
          selectedValue = value.toString();
        });
      },
      items: widget.myList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
          ),
        );
      }).toList(),
    );
  }
}
