import 'package:tessera/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:tessera/features/Booking/view/widgets/event_page.dart';
import 'package:tessera/features/Booking/view/widgets/email_button.dart';
class OrderComplete extends StatelessWidget {
  final Function()? onTap_view;
  const OrderComplete({
    Key? key,
    this.onTap_view,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar:AppBar(
        leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context,'/second');
              },
              icon: Icon(Icons.close)),
        elevation: 3,
        backgroundColor: AppColors.primary,
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: EmailButton(
            buttonText: 'View Your Ticket',
            colourBackground: AppColors.primary,
            colourText: Colors.white,onTap: onTap_view)),),
        body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
          )
        ),
    )
    );
  }
}
