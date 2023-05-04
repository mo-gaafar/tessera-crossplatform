import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Datepick extends StatefulWidget {
  final String textLabel;
  const Datepick({super.key, required this.textLabel});
  @override
  State<Datepick> createState() => _DatepickState();
}

class _DatepickState extends State<Datepick> {
  TextEditingController dateinput = TextEditingController();
  //text editing controller for text field
  late String textlabel;
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    textlabel = widget.textLabel; // initialize the attribute
    super.initState();
  }
   String get output => dateinput.text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dateinput, //editing controller of this TextField
      decoration:  InputDecoration(
          icon: Icon(Icons.calendar_today), //icon of text field
          // ignore: unnecessary_string_interpolations
          labelText: textlabel //label text of field
          ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
                2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(
              formattedDate); //formatted date output using intl package =>  2021-03-16
          //you can implement different kind of Date Format here according to your requirement

          setState(() {
            dateinput.text =
                formattedDate; //set output date to TextField value.
          });
        } else {
          print("Date is not selected");
        }
      },
    );
  }
}
