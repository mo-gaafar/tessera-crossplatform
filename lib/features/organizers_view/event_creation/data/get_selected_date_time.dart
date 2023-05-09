import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GetSelectedDateAndTime {
  var _selectedDate;
  var _selectedTime;
  var _timeZoneName;
  Future selectDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      //we wait for the dialog to return
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (date != null) {
      _selectedDate = DateFormat('yyyy-MM-dd')
          .format(date); //need to be formated as ISO8601
      _timeZoneName = date.timeZoneName;
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
      return ConvertTimeToIso(time);
    } //if the user has selected a date
  }

  String ConvertTimeToIso(TimeOfDay time) {
    String timeString;
    timeString = time.hour.toString() + ':' + time.minute.toString() + ':00';
    return timeString;
  }

  //this will return the non iso format
  getSelectedTime() {
    return _selectedTime;
  }

  getTimeZoneName() {
    return _timeZoneName;
  }
}
