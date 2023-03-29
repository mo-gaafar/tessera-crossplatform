import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tessera/constants/app_colors.dart';

class SimilarEvents extends StatelessWidget {
  const SimilarEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/books.jpeg"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Wed, March 15-Thu, March 16',
              style: const TextStyle(
                  fontFamily: 'NeuePlak',
                  color: AppColors.primary,
                  fontSize: 15,
                  fontWeight: FontWeight.w100),
            ),
            Text(
                'Bestseller Book Bootcamp -Write, Market & Publish Your Book',
                style: const TextStyle(
                    fontFamily: 'NeuePlak',
                    color: AppColors.textOnLight,
                    fontSize: 15,
                    fontWeight: FontWeight.w100)),
            Text('Cairo, Cairo Government 11837',
            style: const TextStyle(
                      fontFamily: 'NeuePlak',
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w100)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      print('icon pressed');
                    },
                    icon: Icon(FontAwesomeIcons.upload)),
                IconButton(
                    onPressed: () {
                      print('icon pressed');
                    },
                    icon: Icon(FontAwesomeIcons.heart))
              ],
            )
          ],
        ),
      ),
    );
  }
}
