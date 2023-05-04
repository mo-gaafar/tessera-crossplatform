import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/organizers_view/ticketing/view/pages/edit_tickets.dart';
import '../../cubit/event_tickets_cubit.dart';
import '../../cubit/tickets_store.dart';
import '../../cubit/tickets_store_cubit.dart';
import '../widgets/card.dart';
import '../widgets/uploadCSV.dart';

class PromoCode extends StatelessWidget {
  const PromoCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        bottomNavigationBar: BottomAppBar(
          child: TextButton(
            onPressed: () {
              //to  publishing
              Navigator.pushNamed(context, '/publishPage');
            },
            child: Text(
              'Add promocode',
              style: TextStyle(
                  fontFamily: 'NeuePlak',
                  color: AppColors.secondaryTextOnLight,
                  fontSize: 25),
            ),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              GenesTableTab(),
            ]
          ),
        )));
  }
}