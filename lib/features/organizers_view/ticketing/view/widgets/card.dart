import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TicketCard extends StatelessWidget {
  const TicketCard(
      {super.key,
      required this.tierName,
      required this.saleSchedule,
      required this.tierPrice,
      required this.availableQuantity, this.onTap});
  final String tierName;
  final String saleSchedule;
  final String tierPrice;
  final int availableQuantity; //current
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Map<String, Color> colorMap = {
      'Scheduled': Colors.yellow,
      'OnSale': Colors.green,
    };
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  tierName,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'NeuePlak',
                      color: AppColors.textOnLight,
                      fontSize: 25),
                ),
                Spacer(),
                IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    Icons.more_vert,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: colorMap[saleSchedule],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  saleSchedule,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'NeuePlak',
                      color: AppColors.textOnLight,
                      fontSize: 25),
                ),
                Spacer(),
                Text(
                  tierPrice,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'NeuePlak',
                      color: AppColors.textOnLight,
                      fontSize: 25),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Available Quantity  ' + availableQuantity.toString(),
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'NeuePlak',
                  color: AppColors.textOnLight,
                  fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
