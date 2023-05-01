import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/event_creation/cubit/createEvent_cubit.dart';

class validation {
  bool dateAndTimeNotNull(context) {
    if (context.read<CreateEventCubit>().currentEvent.endTime == null) {
      context
          .read<CreateEventCubit>()
          .displayError(errormessage: 'Add End Time.');
          return false;
    } else if (context.read<CreateEventCubit>().currentEvent.endDate == null) {
      context
          .read<CreateEventCubit>()
          .displayError(errormessage: 'Add End Date.');
          return false;
    } else if (context.read<CreateEventCubit>().currentEvent.startTime ==
        null) {
      context
          .read<CreateEventCubit>()
          .displayError(errormessage: 'Add Start Time.');
          return false;
    } else if (context.read<CreateEventCubit>().currentEvent.startDate ==
        null) {
      context
          .read<CreateEventCubit>()
          .displayError(errormessage: 'Add Start Date.');
          return false;
    }
    return true;
  }
}
