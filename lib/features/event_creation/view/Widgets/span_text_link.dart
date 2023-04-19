import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/event_creation/data/url_luncher.dart';
class Span_Text_URL extends StatelessWidget {
  String normalText = '';
  String linkText = '';
  Span_Text_URL({this.normalText = '', this.linkText = ''});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(normalText + ' '),
        InkWell(
          onTap: Url_Launcher().launchURL,
          child: Text(
            linkText,
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
