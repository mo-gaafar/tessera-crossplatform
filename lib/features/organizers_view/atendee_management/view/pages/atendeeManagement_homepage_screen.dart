import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/organizers_view/atendee_management/cubit/atendeeManagement_cubit.dart';
import 'package:tessera/features/organizers_view/atendee_management/cubit/atendeeManagement_state.dart';
import 'package:tessera/features/organizers_view/atendee_management/view/widgets/atendeeManagement_evnetslist.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';
import 'package:tessera/constants/app_colors.dart';

class AtendeeManagementHomePage extends StatefulWidget {
  const AtendeeManagementHomePage({super.key});

  @override
  State<AtendeeManagementHomePage> createState() =>
      _AtendeeManagementHomePageState();
}

class _AtendeeManagementHomePageState extends State<AtendeeManagementHomePage> {
  List<bool> _selections = List.generate(2, (_) => false);
  String? ticketType;
  String? isTicketsFree;
  String totalPrice = '0';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            GestureDetector(
              child: Center(
                  child: Text(
                'Clear',
              )),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Clear every thing!'),
                        content: Text(
                            'All the atendee management data you have made will be deleted is this ok with you?'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<AtendeeManagementCubit,
                          AtendeeManagementState>(
                        builder: (context, state) {
                          if (state is AtendeeManagementInfo) {
                            return Text(
                              context
                                  .read<AtendeeManagementCubit>()
                                  .atendeeModel
                                  .totalTicketsPrice!,
                              style: const TextStyle(
                                  fontSize: 48, fontWeight: FontWeight.bold),
                            );
                          }
                          return Text(
                            totalPrice,
                            style: const TextStyle(
                                fontSize: 48, fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                      const Text(
                        '£',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          RadioListTile(
                            title: Text("Free"),
                            value: "Free",
                            groupValue: isTicketsFree,
                            onChanged: (value) {
                              setState(() {
                                isTicketsFree = value.toString();
                                totalPrice = '0';
                                context
                                    .read<AtendeeManagementCubit>()
                                    .atendeeModel
                                    .ticketisFree = true;
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Not Free"),
                            value: "Not Free",
                            groupValue: isTicketsFree,
                            onChanged: (value) {
                              setState(
                                () {
                                  isTicketsFree = value.toString();
                                  totalPrice = (context
                                              .read<AtendeeManagementCubit>()
                                              .atendeeModel
                                              .totalTicketsPrice ==
                                          null)
                                      ? "0"
                                      : context
                                          .read<AtendeeManagementCubit>()
                                          .atendeeModel
                                          .totalTicketsPrice!;
                                  context
                                      .read<AtendeeManagementCubit>()
                                      .atendeeModel
                                      .ticketisFree = false;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                BlocBuilder<AtendeeManagementCubit, AtendeeManagementState>(
                  builder: (context, state) {
                    String? ticketsQuantity = context
                        .read<AtendeeManagementCubit>()
                        .atendeeModel
                        .ticketQuantity;
                    String? ticketTierName = context
                        .read<AtendeeManagementCubit>()
                        .atendeeModel
                        .ticketTierName;
                    if (ticketsQuantity == null) {
                      ticketsQuantity = '0';
                    }
                    if (ticketTierName == null) {
                      ticketTierName = '';
                    }
                    return Column(
                      children: [
                        AtendeeEventsList(),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                              'You chose ${ticketsQuantity} tickets of type ${ticketTierName}'),
                        ),
                      ],
                    );
                  },
                ),
                const Spacer(),
                Container(
                  child: EmailButton(
                    buttonText: 'Add Atendee Detail',
                    colourBackground: AppColors.primary,
                    colourText: Colors.white,
                    onTap: () {
                      Navigator.pushNamed(context, '/addatendeedetails');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
