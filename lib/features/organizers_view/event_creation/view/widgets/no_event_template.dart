import 'package:flutter/material.dart';

class NoEvenTemplate extends StatelessWidget {
  String text = '';
  NoEvenTemplate(this.text);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 22.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 55,
                child: Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'NeuePlak',
                fontWeight: FontWeight.w200),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
