import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/events/view/pages/check_out.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
showAlertDialog(BuildContext context,bool promocode,int pricing) {
  // onChanged callback
  late String promo;
  String text = "No Value Entered";
  int count = 0;
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("CheckOut"),
    onPressed: () {
      Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>CheckOut(feesText: pricing.toString()),),);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Choose the number of tickets and Enter the promocode'),
    content: Column(
      children: [
        Row(children: [
        IconButton(onPressed: () {
          count++;
        }, icon: Icon(Icons.maximize_rounded)),
        Text(count.toString()),
        IconButton(onPressed: () {
          count--;
        }, icon: Icon(Icons.minimize_rounded)),
        ],),
        Visibility(
          visible: promocode,
          child: TextField(
            decoration: const InputDecoration(
                labelText: "promocode",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'enter your promocode',
                helperText: 'must be a valid'),
                onChanged: (value){ 
                  promo = value;
                }, //output
          ),
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
