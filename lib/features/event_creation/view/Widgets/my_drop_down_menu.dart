import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/event_creation/cubit/createEvent_cubit.dart';

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
          if (widget.type == 'location') {
            context.read<CreateEventCubit>().currentEvent.locationType =
                selectedValue.toString();
          } else if (widget.type == 'Privacy') {
            if (selectedValue.toString() == 'Public event') {
              context.read<CreateEventCubit>().currentEvent.isPublic = true;
            } else {
              context.read<CreateEventCubit>().currentEvent.isPublic = false;
            }
            print(context.read<CreateEventCubit>().currentEvent.isPublic);
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
