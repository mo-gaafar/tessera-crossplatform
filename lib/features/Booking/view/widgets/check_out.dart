import 'package:tessera/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tessera/features/Booking/view/widgets/email_button.dart';
class CheckOut extends StatelessWidget {
  final String feesText; //money or free
  final Function()? onTap_checkout;
  const CheckOut({
    Key? key,
    required this.feesText,
    this.onTap_checkout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Text(
          'Check out',
          style: TextStyle(
              fontFamily: 'NeuePlak', color: Colors.white, fontSize: 25),
        ),
        leading: Icon(Icons.close),
        backgroundColor: AppColors.primary,
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                feesText,
                style: TextStyle(
                    fontFamily: 'NeuePlak',
                    color: AppColors.textOnLight,
                    fontSize: 30),
              ),
            ),
            Expanded(
                flex: 3,
                child: EmailButton(
                    buttonText: 'checkout',
                    colourBackground: AppColors.primary,
                    colourText: Colors.white,onTap: onTap_checkout,)),
          ],
        ),
      )),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: 
                      TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your first name',
                ),
              ),
                  ),
                  Expanded(child: 
                  TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your last name',
            ),
          ),)
                ],
              ),
              TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your Email address',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your city/state/country',
            ),
          ),
          Text(
        'pay with' ,
        style: const TextStyle(
            fontFamily: 'NeuePlak', color: AppColors.textOnLight, fontSize: 20),
      ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your card number',
            ),
          ),
          Row(
                children: [
                  Expanded(child: 
                      TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Expiration date',
                ),
              ),
                  ),
                  Expanded(child: 
                  TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your security code',
            ),
          ),)
                ],
              ),
              TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your zip code',
            ),
          ),
            ],
          ),
        )
      ),
    );
  }
}