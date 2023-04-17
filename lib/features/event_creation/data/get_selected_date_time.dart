import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GetSelectedDateAndTime {
  var _selectedDate;
  var _selectedTime;
  Future selectDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      //we wait for the dialog to return
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (date != null) {
      _selectedDate = DateFormat.yMMMMd("en_US")
          .format(date); //need to be formated as ISO8601
          return _selectedDate;
    } //if the user has selected a date
  }

  getSelectedDate() {
    return _selectedDate;
  }

  Future selectTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      //we wait for the dialog to return
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      _selectedTime = time.format(context); //need to be formated as ISO8601
      return _selectedTime;
    } //if the user has selected a date
  }

  getSelectedTime() {
    return _selectedTime;
  }
}
