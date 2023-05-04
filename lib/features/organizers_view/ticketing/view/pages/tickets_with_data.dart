import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tessera/constants/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tessera/features/organizers_view/ticketing/view/pages/admission.dart';
import 'package:tessera/features/organizers_view/ticketing/view/pages/promocode.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false, 
          bottom: const TabBar(
            labelColor: AppColors.primary, //<-- selected text color
            unselectedLabelColor: AppColors.secondary, //<-- Unselected text 
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(
                text: 'Addmission',
              ),
              Tab(
                text: 'Promo Codes',
              ),
            ],
          ),
          title: const Text(
            'Tickets',
            style: TextStyle(
                fontFamily: 'NeuePlak',
                color: AppColors.textOnLight,
                fontSize: 25),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBarView(
              children: [Admission()
                ,PromoCode()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
