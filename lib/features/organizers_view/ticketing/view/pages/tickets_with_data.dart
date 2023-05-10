import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/organizers_view/ticketing/view/pages/admission.dart';
import 'package:tessera/features/organizers_view/ticketing/view/pages/promocode.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key, required this.lisofteirs,required this.id});
  final List lisofteirs;
  final String id;

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
          title: Text(
            'Tickets',
            style: TextStyle(
                fontFamily: 'NeuePlak',
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 25),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBarView(
              children: [
                Admission(
                  ticketTiersList: lisofteirs, id: id,
                ),
                PromoCode(id: id,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
