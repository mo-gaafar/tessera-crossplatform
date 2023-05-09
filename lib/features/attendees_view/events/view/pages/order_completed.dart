import 'package:tessera/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:tessera/features/attendees_view/events/view/widgets/email_button.dart';

class OrderComplete extends StatelessWidget {
  const OrderComplete({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                //back to event page
                Navigator.pushNamed(context, '/second');
              },
              icon: const Icon(Icons.close)),
          elevation: 3,
          backgroundColor: AppColors.primary,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: EmailButton(
                  buttonText: 'View Your Ticket',
                  colourBackground: AppColors.primary,
                  colourText: Colors.white,
                  onTap: () {
                    //back to landing page
                    Navigator.pushNamed(context, '/');
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('Your E-Ticket Was Sent Via Email'),
                      shape: StadiumBorder(),
                      behavior: SnackBarBehavior.floating,
                    ));
                  })),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                'Order Completed',
                style: TextStyle(
                    color: AppColors.textOnLight,
                    fontSize: 40.0,
                    fontFamily: 'NeuePlak'),
                textAlign: TextAlign.center,
              ),
              const Text(
                'See You At The Event!',
                style: TextStyle(
                    color: AppColors.secondaryTextOnLight,
                    fontSize: 20.0,
                    fontFamily: 'NeuePlak'),
                textAlign: TextAlign.center,
              ),
            ],
          )),
        ));
  }
}
