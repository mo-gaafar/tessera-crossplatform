import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/organizers_view/ticketing/view/pages/tickets_with_data.dart';

import '../../../../../core/services/validation/form_validator.dart';
import '../../cubit/event_tickets_cubit.dart';
import '../../cubit/tickets_store_cubit.dart';
import '../../data/tier_data.dart';

String changetoIso(String time, String date) {
  String originalDateString = time + ' ' + date;
  DateTime originalDateTime =
      DateFormat('h:mm a yyyy-MM-dd').parse(originalDateString);
  String isoDateTimeString = originalDateTime.toUtc().toIso8601String();
  return isoDateTimeString;
}

class AddTickets extends StatefulWidget {
  AddTickets({super.key});

  @override
  State<AddTickets> createState() => _AddTicketsState();
}

class _AddTicketsState extends State<AddTickets> {
  final formKey = GlobalKey<FormState>();
  late String ticketName;
  late String quantity;
  late String price;
  TextEditingController dateinputStart = TextEditingController();
  TextEditingController timeinputStart = TextEditingController();
  TextEditingController dateinputEnd = TextEditingController();
  TextEditingController timeinputEnd = TextEditingController();
  FormValidator formValidator = FormValidator();
  String id = '64560b5b36af37a7a313b0d6';

  @override
  void initState() {
    dateinputStart.text = '';
    timeinputStart.text = '';
    dateinputEnd.text = '';
    timeinputEnd.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              //back to ticketing default
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left)),
        elevation: 0,
        backgroundColor: AppColors.lightBackground,
        title: const Text(
          'Add Tickets',
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
                if (formKey.currentState!.validate()) {
                  print('trying to add');
                  String message = await context
                      .read<EventTicketsCubit>()
                      .addTicketData(
                          TierModel(
                                  tierName: ticketName,
                                  maxCapacity: int.parse(quantity),
                                  price: price,
                                  startSelling: changetoIso(
                                      timeinputStart.text, dateinputStart.text),
                                  endSelling: changetoIso(
                                      timeinputEnd.text, dateinputEnd.text))
                              .toMap(),
                          id);
                  if (message == 'successfully added') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 3),
                      // ignore: prefer_interpolation_to_compose_strings
                      content: Text(message as String),
                      shape: StadiumBorder(),
                      behavior: SnackBarBehavior.floating,
                    ));
                    var resp = await context
                        .read<EventTicketsCubit>()
                        .getTicketsData(id);
                    if (resp['success'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TicketPage(
                                  lisofteirs: resp['ticketTiers'] as List,
                                )),
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
                      duration: Duration(seconds: 3),
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
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Ticket Name *',
                          helperText: 'Required'),
                      validator: (value) {
                        ticketName = value!;
                        if (ticketName.trim().isEmpty) {
                          return 'Ticket Name is required.';
                        }
                        return formValidator.ticketNameValidty(
                            ticketName); //not more than 50 characters
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Available Quantity *',
                          helperText: 'Required'),
                      validator: (value) {
                        quantity = value!;
                        if (quantity.trim().isEmpty) {
                          return 'Available Quantity is required.';
                        }
                        return formValidator
                            .numberValidty(value); //should be number
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<EventTicketsCubit, EventTicketsState>(
                      builder: (context, state) {
                        print(state.toString());
                        if (state is TicketIsPaid ||
                            state is TicketDefaultPaid) {
                          print('hena');
                          return TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Price *',
                                helperText: 'Required'),
                            validator: (value) {
                              price = value!;
                              if (quantity.trim().isEmpty) {
                                return 'Price is required.';
                              }
                              return formValidator
                                  .numberValidty(value); //should be number
                            },
                          );
                        } else {
                          print('here?');
                          price = 'Free';
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
