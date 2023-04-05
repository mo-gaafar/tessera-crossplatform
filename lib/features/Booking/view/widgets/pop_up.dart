import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';

showAlertDialog(BuildContext context) {
  // onChanged callback
  late String title;
  String text = "No Value Entered";
  String dropdownValue = '1';
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pushNamed(context,'/second');
    },
  );
  Widget continueButton = TextButton(
    child: Text("CheckOut"),
    onPressed: () {
      Navigator.of(context).pushNamed('/fourth');
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Choose the number of tickets and Enter the promocode'),
    content: Column(
      children: [
        Row(children: [
        TextButton(onPressed: () {}, child: Text('1')),
        TextButton(onPressed: () {}, child: Text('2')),
        TextButton(onPressed: () {}, child: Text('3')),
        TextButton(onPressed: () {}, child: Text('4')),
        ],),
        TextField(
          decoration: const InputDecoration(
              labelText: "promocode",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              hintText: 'enter your promocode',
              helperText: 'must be a valid'),
              onChanged: (value) => title = value, //output
        ),
      ],
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(child: alert);
    },
  );
}
