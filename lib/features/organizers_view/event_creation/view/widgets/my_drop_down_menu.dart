import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_cubit.dart';

class MyDropDownMenu extends StatefulWidget {
  MyDropDownMenu({super.key, required this.myList, this.type});

  final List<String> myList;
  final String? type;
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
          if (widget.type == 'Privacy') {
            if (selectedValue.toString() == 'Public event') {
              context.read<CreateEventCubit>().currentEvent.isPublic = true;
            } else {
              context.read<CreateEventCubit>().currentEvent.isPublic = false;
            }
          }
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
