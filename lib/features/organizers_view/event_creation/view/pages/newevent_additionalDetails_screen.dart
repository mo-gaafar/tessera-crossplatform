import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/core/widgets/app_scaffold.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_cubit.dart';
import 'package:tessera/constants/constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tessera/features/organizers_view/atendee_management/cubit/atendeeManagement_cubit.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Widgets/my_image_picker.dart';

class AdditionalDetailsPage extends StatefulWidget {
  const AdditionalDetailsPage({super.key});

  @override
  State<AdditionalDetailsPage> createState() => _AdditionalDetailsPageState();
}

class _AdditionalDetailsPageState extends State<AdditionalDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(
          title: const Text(
            "Add Additional Details",
            style: TextStyle(
                fontFamily: 'NeuePlak',
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyImagePicker(),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: const Text(
                'Enter a brief summary of your event so guests know what to expect',
                style: TextStyle(
                    color: Colors.grey, fontSize: 20.0, fontFamily: 'NeuePlak'),
                textAlign: TextAlign.left,
              ),
            ),
            TextField(
              onChanged: (value) {
                context.read<CreateEventCubit>().currentEvent.eventSummary =
                    value;
              },
            ),
            Spacer(),
            EmailButton(
              buttonText: 'Add the data',
              colourBackground: AppColors.buttonColor,
              colourText: AppColors.lightBackground,
              onTap: () {
                print('is it added');
              },
            )
          ],
        ));
  }
}
