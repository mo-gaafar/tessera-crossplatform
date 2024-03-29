import 'package:flutter/material.dart';
import '../../cubit/event_tickets_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//First Page in ticketing
class TicketDefault extends StatelessWidget {
  const TicketDefault({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ticketing',
          textAlign: TextAlign.left,
          style: TextStyle(
              fontFamily: 'NeuePlak',
              fontSize: 25),
        ),
        leading: IconButton(
            onPressed: () {
              //back to creater first page
              Navigator.pushNamed(context, '/creatorlanding');
            },
            icon: const Icon(Icons.chevron_left)),
        elevation: 3,
        backgroundColor: AppColors.lightBackground,
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 55,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Icon(
                        FontAwesomeIcons.ticket,
                        color: Colors.grey,
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'You Don\'t Have Any Tickets Yet',
                    style: TextStyle(
                        fontFamily: 'NeuePlak',
                        color: AppColors.secondaryTextOnLight,
                        fontSize: 25),
                  ),
                  Text(
                    'Start Adding Now!',
                    style: TextStyle(
                        fontFamily: 'NeuePlak',
                        color: AppColors.secondaryTextOnLight,
                        fontSize: 25),
                  ),
                ],
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          context.read<EventTicketsCubit>().eventPricingdefault();
          Navigator.pushReplacementNamed(
                              context,
                              '/addtickets',
                              arguments: id as String, //GIVING THE PRICE AS Int
                            );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
