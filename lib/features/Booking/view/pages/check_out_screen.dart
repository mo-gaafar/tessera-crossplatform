import 'package:flutter/widgets.dart';
import 'package:tessera/features/Booking/view/widgets/check_out.dart';
import 'package:flutter/material.dart';
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: CheckOut(feesText: '150',timerOut: () {
      Navigator.pushNamed(context, '/second');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text('TIME OUT'),
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          
          ));
    },));
  }
}
