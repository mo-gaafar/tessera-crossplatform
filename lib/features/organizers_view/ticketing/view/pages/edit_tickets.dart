// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_cubit.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/organizers_view/ticketing/data/edit_tier_model.dart';
import 'package:tessera/features/organizers_view/ticketing/view/pages/tickets_with_data.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import '../../../../../core/services/validation/form_validator.dart';
import '../../cubit/event_tickets_cubit.dart';

import '../../data/tier_data.dart';

List changeFromIso(String datetimestart) {
  DateTime dateTime = DateTime.parse(datetimestart);
  String dateString = DateFormat('yyyy-MM-dd').format(dateTime);
  String timeString = DateFormat('h:mm a').format(dateTime.toLocal());
  return [dateString, timeString];
}

String changetoIso(String time, String date) {
  String originalDateString = time + ' ' + date;
  DateTime originalDateTime =
      DateFormat('h:mm a yyyy-MM-dd').parse(originalDateString);
  String isoDateTimeString = originalDateTime.toUtc().toIso8601String();
  return isoDateTimeString;
}

class EditTickets extends StatefulWidget {
  const EditTickets({
    Key? key,
    required this.ticketName,
    required this.quantity,
    required this.price,
    required this.datetimestart,
    required this.datetimeend, required this.id,
  }) : super(key: key);

  final String ticketName;
  final int quantity;
  final String price;
  final String datetimestart; //from the already edited
  final String datetimeend;
  final String  id;

  @override
  State<EditTickets> createState() => _EditTicketsState();
}

class _EditTicketsState extends State<EditTickets> {
  
  final formKey = GlobalKey<FormState>();
  TextEditingController dateinputStart = TextEditingController();
  TextEditingController timeinputStart = TextEditingController();
  TextEditingController dateinputEnd = TextEditingController();
  TextEditingController timeinputEnd = TextEditingController();
  FormValidator formValidator = FormValidator();
  late String ticketNameEdit;
  late String quantityEdit;
  late String priceEdit;
  //late String datestartEdit=changeFromIso(widget.datetimestart)[0];
  //late String timestartWdit=changeFromIso(widget.datetimestart)[1];
  //late String dateendEdit=changeFromIso(widget.datetimeend)[0];
  //late String timeendEdit=changeFromIso(widget.datetimeend)[1];
  void initState() {
    dateinputStart.text = changeFromIso(widget.datetimestart)[0];
    timeinputStart.text = changeFromIso(widget.datetimestart)[1];
    dateinputEnd.text = changeFromIso(widget.datetimeend)[0];
    timeinputEnd.text = changeFromIso(widget.datetimeend)[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.lightBackground,
        title: const Text(
          'Edit Tickets',
          textAlign: TextAlign.left,
          style: TextStyle(
              fontFamily: 'NeuePlak',
              color: AppColors.textOnLight,
              fontSize: 25),
        ),
        //backgroundColor: AppColors.primary,
        actions: [
          IconButton(
              onPressed: () async {
               // id = context.read<CreateEventCubit>().currentEvent.eventID!;
                if (formKey.currentState!.validate()) {
                  String message = await context
                      .read<EventTicketsCubit>()
                      .editTicketData(
                          EditTierModel(
                              desiredTierName: widget.ticketName,
                              ticketTiers: [
                                TierModel(
                                        tierName: ticketNameEdit,
                                        maxCapacity: int.parse(quantityEdit),
                                        price: priceEdit,
                                        startSelling: changetoIso(
                                            timeinputStart.text,
                                            dateinputStart.text),
                                        endSelling: changetoIso(
                                            timeinputEnd.text,
                                            dateinputEnd.text))
                                    .toMap()
                              ]).toMap(),
                          widget.id,
                          context.read<AuthCubit>().currentUser.accessToken!);
                  if (message == 'successfully edited') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 3),
                      // ignore: prefer_interpolation_to_compose_strings
                      content: Text(message as String),
                      shape: StadiumBorder(),
                      behavior: SnackBarBehavior.floating,
                    ));
                    var resp = await context
                        .read<EventTicketsCubit>()
                        .getTicketsData(widget.id);
                    if (resp['success'] == true) {
                      Navigator.pushNamed(
                        context,
                        '/ticketspage',
                        arguments: [resp['ticketTiers']
                            as List, widget.id as String]
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 3),
                        // ignore: prefer_interpolation_to_compose_strings
                        content: Text(resp['message'] as String),
                        shape: StadiumBorder(),
                        behavior: SnackBarBehavior.floating,
                      ));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 2),
                      // ignore: prefer_interpolation_to_compose_strings
                      content: Text(message as String),
                      shape: StadiumBorder(),
                      behavior: SnackBarBehavior.floating,
                    ));
                  }
                }
              },
              icon: const Icon(Icons.done)),
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: OutlinedButton(
                          onPressed: () {
                            context.read<EventTicketsCubit>().eventIsPaid();
                          },
                          child: const Text(
                            'Paid',
                            style: TextStyle(
                                fontFamily: 'NeuePlak',
                                color: AppColors.textOnLight,
                                fontSize: 20),
                          ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: OutlinedButton(
                          onPressed: () {
                            context.read<EventTicketsCubit>().eventIsFree();
                          },
                          child: const Text(
                            'Free',
                            style: TextStyle(
                                fontFamily: 'NeuePlak',
                                color: AppColors.textOnLight,
                                fontSize: 20),
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: widget.ticketName,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Ticket Name *',
                          helperText: 'Required'),
                      validator: (value) {
                        ticketNameEdit = value!;
                        if (ticketNameEdit.trim().isEmpty) {
                          return 'Ticket Name is required.';
                        }
                        return formValidator.ticketNameValidty(
                            ticketNameEdit); //not more than 50 characters
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: widget.quantity.toString(),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Available Quantity *',
                          helperText: 'Required'),
                      validator: (value) {
                        quantityEdit = value!;
                        if (quantityEdit.trim().isEmpty) {
                          return 'Available Quantity is required.';
                        }
                        return formValidator
                            .numberValidty(quantityEdit); //should be number
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<EventTicketsCubit, EventTicketsState>(
                      builder: (context, state) {
                        print(state.toString());
                        if (state is TicketIsPaid ||
                            state is TicketDefaultPaid ||
                            (state is TicketEventInfoRetrived &&
                                widget.price != 'Free')) {
                          print('hena');
                          return TextFormField(
                            initialValue: widget.price,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Price *',
                                helperText: 'Required'),
                            validator: (value) {
                              priceEdit = value!;
                              if (priceEdit.trim().isEmpty) {
                                return 'Price is required.';
                              }
                              return formValidator
                                  .priceValidty(priceEdit); //should be number
                            },
                          );
                        } else {
                          print('here?');
                          priceEdit = 'Free';
                          return const TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Price',
                              hintText: 'Free',
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Select when the tickets will be available.',
                      style: TextStyle(
                          fontFamily: 'NeuePlak',
                          color: AppColors.secondaryTextOnLight,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller:
                                dateinputStart, //editing controller of this TextField
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                icon: Icon(
                                    Icons.calendar_today), //icon of text field
                                labelText:
                                    "Enter Start Selling  Date" //label text of field
                                ),
                            readOnly:
                                true, //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement
                                setState(() {
                                  dateinputStart.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Start Date is not selected");
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextField(
                          controller:
                              timeinputStart, //editing controller of this TextField
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              icon: Icon(Icons.timer), //icon of text field
                              labelText:
                                  "Enter Start Selling Time" //label text of field
                              ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (pickedTime != null) {
                              print(pickedTime.format(context));
                              setState(() {
                                timeinputStart.text =
                                    pickedTime.format(context).toString();
                                //formattedTime; //set the value of text field.
                              });
                            } else {
                              print("Start Time is not selected");
                            }
                          },
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller:
                                dateinputEnd, //editing controller of this TextField
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                icon: Icon(
                                    Icons.calendar_today), //icon of text field
                                labelText:
                                    "Enter End Selling Date" //label text of field
                                ),
                            readOnly:
                                true, //set it true, so that user will not able to edit text
                            onTap: () async {
                              //2023-05-03
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement
                                setState(() {
                                  dateinputEnd.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("End Date is not selected");
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextField(
                          controller:
                              timeinputEnd, //editing controller of this TextField
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              icon: Icon(Icons.timer), //icon of text field
                              labelText:
                                  "Enter End Selling Time" //label text of field
                              ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (pickedTime != null) {
                              print(pickedTime.format(context)); //5:46 PM
                              setState(() {
                                timeinputEnd.text =
                                    pickedTime.format(context).toString();
                                //formattedTime; //set the value of text field.
                              });
                            } else {
                              print("End Time is not selected");
                            }
                          },
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
