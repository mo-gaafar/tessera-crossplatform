import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_cubit.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Widgets/popup_menu.dart';

class ChooseFromPopup extends StatefulWidget {
  const ChooseFromPopup({super.key});

  @override
  State<ChooseFromPopup> createState() => _ChooseFromPopupState();
}

class _ChooseFromPopupState extends State<ChooseFromPopup> {
  String text = 'Select a Category';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Event category'),
        GestureDetector(
          child: Text(text),
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Select Event Category'),
                content: PopupMenu(selectEvent: 'Category'),
              ),
            );
            setState(() {
              text = (context
                          .read<CreateEventCubit>()
                          .currentEvent
                          .eventCategory ==
                      null)
                  ? 'Select Event Category'
                  : context
                      .read<CreateEventCubit>()
                      .currentEvent
                      .eventCategory!;
            });
          },
        ),
      ],
    );
  }
}
