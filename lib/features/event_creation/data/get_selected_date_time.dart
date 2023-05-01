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
      _selectedDate = DateFormat('yyyy-MM-dd')
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
      return ConvertTimeToIso(_selectedTime);
    } //if the user has selected a date
  }

  String ConvertTimeToIso(var timeVariable) {
    String passedTime = timeVariable.toString();
    String time;
    if (passedTime.contains('PM')) {
      String twentyFourHourTime = (int.parse(passedTime.substring(0, 1)) == 12)
          ? '00'
          : (int.parse(passedTime.substring(0, 1)) + 12).toString();
      time = twentyFourHourTime + ':' + passedTime.substring(2, 4) + ':00';
    } else {
      time = '0' + passedTime.substring(0, 4) + ':00';
    }
    return time;
  }

  //this will return the non iso format
  getSelectedTime() {
    return _selectedTime;
  }
}
