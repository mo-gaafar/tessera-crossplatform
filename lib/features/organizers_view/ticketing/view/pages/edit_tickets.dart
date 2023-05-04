// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/organizers_view/event_creation/view/Widgets/pick_date_time.dart';

import '../../../../../core/services/validation/form_validator.dart';
import '../../cubit/event_tickets_cubit.dart';
import '../../cubit/tickets_store_cubit.dart';
import '../../data/tier_data.dart';

class EditTickets extends StatefulWidget {
  const EditTickets({
    Key? key,
    required this.ticketName,
    required this.quantity,
    required this.price,
    required this.datestart,
    required this.timestart,
    required this.dateend,
    required this.timeend,
    required this.index,
  }) : super(key: key);

  final String ticketName;
  final String quantity;
  final String price;
  final String datestart;
  final String timestart;
  final String dateend;
  final String timeend;
  final int index;

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
  late String datestartEdit;
  late String timestartWdit;
  late String dateendEdit;
  late String timeendEdit;
  void initState() {
    dateinputStart.text = widget.datestart;
    timeinputStart.text = widget.timestart;
    dateinputEnd.text = widget.dateend;
    timeinputEnd.text = widget.timeend;
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
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  //save and move to the next page
                  context.read<MyCubit>().updateData(
                      widget.index,
                      TierModel(
                              name: ticketNameEdit,
                              quantity: quantityEdit,
                              price: priceEdit,
                              startDate: dateinputStart.text,
                              endDate: dateinputEnd.text,
                              startTime: timeinputStart.text,
                              endTime: timeinputEnd.text)
                          .toMap());

                  Navigator.pushNamed(context, '/ticketseditpromo');
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
                        return formValidator.nameValidty(
                            ticketNameEdit); //not more than 50 characters
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: widget.quantity,
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
                            state is TicketDefaultPaid) {
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
                                  .numberValidty(priceEdit); //should be number
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
