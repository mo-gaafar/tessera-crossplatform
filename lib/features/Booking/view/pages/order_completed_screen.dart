import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tessera/features/Booking/view/widgets/see_more.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/Booking/view/widgets/order_completed.dart';

class OrdercompleteScreen extends StatelessWidget {
  const OrdercompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: OrderComplete(onTap_view: () {
      Navigator.pushNamed(context, '/');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Your E-Ticket Was Sent Via Email'),
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          
          ));
    }));
  }
}
