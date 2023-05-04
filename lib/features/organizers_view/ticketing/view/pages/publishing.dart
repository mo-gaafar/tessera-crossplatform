import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/organizers_view/ticketing/cubit/event_tickets_cubit.dart';

import '../../../../../core/services/validation/form_validator.dart';

class PublishPage extends StatefulWidget {
  const PublishPage({super.key});

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  late String privacy = ''; //event is public or private
  late String publicly = ''; //will ever be public later
  late String Schedule = ''; //publish now or later
  TextEditingController datePublish = TextEditingController();
  TextEditingController timePublish = TextEditingController();
  TextEditingController datePublic = TextEditingController();
  TextEditingController timePublic = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FormValidator formValidator = FormValidator();
  late String passward;
  String dropdownValue = 'Anyone with the Link';

  @override
  void initState() {
    datePublic.text = '';
    timePublic.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          child: TextButton(
            onPressed: () {
              //to  publishing
              Navigator.pushNamed(context, '/creatorlanding');
            },
            child: Text(
              'Publish',
              style: TextStyle(
                  fontFamily: 'NeuePlak',
                  color: AppColors.secondaryTextOnLight,
                  fontSize: 25),
            ),
          ),
        ),
      appBar: AppBar(
        title: const Text(
          'Publishing',
          textAlign: TextAlign.left,
          style: TextStyle(
              fontFamily: 'NeuePlak',
              color: AppColors.textOnLight,
              fontSize: 25),
        ),
        leading: IconButton(
            onPressed: () {
              //back to creater first page
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left)),
        actions: [
          IconButton(
              onPressed: () {
                //to home page
              },
              icon: const Icon(Icons.done)),
        ],
        elevation: 3,
        backgroundColor: AppColors.lightBackground,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'who can see your event?',
                  style: TextStyle(
                      fontFamily: 'NeuePlak',
                      color: AppColors.secondaryTextOnLight,
                      fontSize: 25),
                ),
                Row(
                  children: [
                    Radio(
                        value: 'Public',
                        groupValue: privacy,
                        onChanged: (value) {
                          setState(() {
                            privacy = value!;
                            context.read<EventTicketsCubit>().EventIsPublic();
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Public',
                      style: TextStyle(
                          fontFamily: 'NeuePlak',
                          color: AppColors.secondaryTextOnLight,
                          fontSize: 25),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: 'Private',
                        groupValue: privacy,
                        onChanged: (value) {
                          setState(() {
                            privacy = value!;
                            context.read<EventTicketsCubit>().EventIsPrivate();
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Private',
                      style: TextStyle(
                          fontFamily: 'NeuePlak',
                          color: AppColors.secondaryTextOnLight,
                          fontSize: 25),
                    ),
                  ],
                ),
                BlocBuilder<EventTicketsCubit, EventTicketsState>(
                  builder: (context, state) {
                    if (state is EventPublic ||
                        state is EventPublishNow ||
                        state is EventPublishLater) {
                      return Column(
                        children: [
                          Text(
                            'When should we publish your event',
                            style: TextStyle(
                                fontFamily: 'NeuePlak',
                                color: AppColors.secondaryTextOnLight,
                                fontSize: 25),
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 'Publish Now',
                                  groupValue: Schedule,
                                  onChanged: (value) {
                                    setState(() {
                                      Schedule = value!;
                                      context
                                          .read<EventTicketsCubit>()
                                          .EventIsPublicAndPublishNow();
                                    });
                                  }),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Publish Now',
                                style: TextStyle(
                                    fontFamily: 'NeuePlak',
                                    color: AppColors.secondaryTextOnLight,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 'Later',
                                  groupValue: Schedule,
                                  onChanged: (value) {
                                    setState(() {
                                      Schedule = value!;
                                      context
                                          .read<EventTicketsCubit>()
                                          .EventIsPublicAndPublishLater();
                                    });
                                  }),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Publish Later',
                                style: TextStyle(
                                    fontFamily: 'NeuePlak',
                                    color: AppColors.secondaryTextOnLight,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                          BlocBuilder<EventTicketsCubit, EventTicketsState>(
                            builder: (context, state) {
                              if (state is EventPublishLater) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller:
                                            datePublish, //editing controller of this TextField
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            icon: Icon(Icons
                                                .calendar_today), //icon of text field
                                            labelText:
                                                "Enter Publish  Date" //label text of field
                                            ),
                                        readOnly:
                                            true, //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(
                                                      2000), //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2101));

                                          if (pickedDate != null) {
                                            print(
                                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
                                            print(
                                                formattedDate); //formatted date output using intl package =>  2021-03-16
                                            //you can implement different kind of Date Format here according to your requirement
                                            setState(() {
                                              datePublish.text =
                                                  formattedDate; //set output date to TextField value.
                                            });
                                          } else {
                                            print(
                                                "Publish  Date is not selected");
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
                                          timePublish, //editing controller of this TextField
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          icon: Icon(
                                              Icons.timer), //icon of text field
                                          labelText:
                                              "Enter Publish Time" //label text of field
                                          ),
                                      readOnly:
                                          true, //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          initialTime: TimeOfDay.now(),
                                          context: context,
                                        );

                                        if (pickedTime != null) {
                                          print(pickedTime.format(context));
                                          setState(() {
                                            timePublish.text = pickedTime
                                                .format(context)
                                                .toString();
                                            //formattedTime; //set the value of text field.
                                          });
                                        } else {
                                          print("Publish Time is not selected");
                                        }
                                      },
                                    ))
                                  ],
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          )
                        ],
                      );
                    } else if (state is EventPrivate ||
                        state is EventAccessWithLink ||
                        state is EventAccessWithPassword ||
                                  state
                                      is EventAccessWithPasswordAndBecamePublic ||
                                  state is EventAccessWithLinkAndBecamePublic || state is EventAccessWithPasswordAndKeptPrivate || state is EventAccessWithLinkAndKeptPrivate) {
                      return Column(
                        children: [
                          Text(
                            'Choose Your Audiance',
                            style: TextStyle(
                                fontFamily: 'NeuePlak',
                                color: AppColors.secondaryTextOnLight,
                                fontSize: 25),
                          ),
                          DropdownButton<String>(
                            // Step 3.
                            value: dropdownValue,
                            // Step 4.
                            items: <String>[
                              'Anyone with the Link',
                              'Only People With Passward'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }).toList(),
                            // Step 5.
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                                if (dropdownValue == 'Anyone with the Link') {
                                  context
                                      .read<EventTicketsCubit>()
                                      .EventIsPrivateAndWithLink();
                                } else if (dropdownValue ==
                                    'Only People With Passward') {
                                  context
                                      .read<EventTicketsCubit>()
                                      .EventIsPrivateAndWithPassward();
                                }
                              });
                            },
                          ),
                          BlocBuilder<EventTicketsCubit, EventTicketsState>(
                            builder: (context, state) {
                              if (state is EventAccessWithPassword ||
                                  state
                                      is EventAccessWithPasswordAndBecamePublic ||
                                  state is EventAccessWithPasswordAndKeptPrivate) {
                                return TextFormField(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Password *',
                                      helperText: 'Required'),
                                  validator: (value) {
                                    passward = value!;
                                    if (passward.trim().isEmpty) {
                                      return 'Password is required.';
                                    }
                                    return formValidator.passowrdValidty(
                                        passward); //not more than 50 characters
                                  },
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          ),
                          Text(
                            'Will this event ever be public?',
                            style: TextStyle(
                                fontFamily: 'NeuePlak',
                                color: AppColors.secondaryTextOnLight,
                                fontSize: 25),
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 'No',
                                  groupValue: publicly,
                                  onChanged: (value) {
                                    setState(() {
                                      publicly = value!;
                                      if (dropdownValue ==
                                          'Anyone with the Link') {
                                        context
                                            .read<EventTicketsCubit>()
                                            .EventKeptPrivateAndWithLink();
                                      } else if (dropdownValue ==
                                          'Only People With Passward') {
                                        context
                                            .read<EventTicketsCubit>()
                                            .EventKeptPrivateAndWithPassward();
                                      }
                                    });
                                  }),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'No, Keep it Private',
                                style: TextStyle(
                                    fontFamily: 'NeuePlak',
                                    color: AppColors.secondaryTextOnLight,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 'Yes',
                                  groupValue: publicly,
                                  onChanged: (value) {
                                    setState(() {
                                      publicly = value!;
                                      if (dropdownValue ==
                                          'Anyone with the Link') {
                                        context
                                            .read<EventTicketsCubit>().EventBecamePublicAndWithLink()
                                            ;
                                      } else if (dropdownValue ==
                                          'Only People With Passward') {
                                        context
                                            .read<EventTicketsCubit>().EventBecamePublicAndWithPassward();
                                      }
                                    });
                                  }),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Yes, Schedule to share Publicly',
                                style: TextStyle(
                                    fontFamily: 'NeuePlak',
                                    color: AppColors.secondaryTextOnLight,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                          BlocBuilder<EventTicketsCubit, EventTicketsState>(
                            builder: (context, state) {
                              if (state is EventAccessWithPasswordAndBecamePublic ||state is EventAccessWithLinkAndBecamePublic) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller:
                                            datePublic, //editing controller of this TextField
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            icon: Icon(Icons
                                                .calendar_today), //icon of text field
                                            labelText:
                                                "Enter Public  Date" //label text of field
                                            ),
                                        readOnly:
                                            true, //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(
                                                      2000), //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2101));

                                          if (pickedDate != null) {
                                            print(
                                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
                                            print(
                                                formattedDate); //formatted date output using intl package =>  2021-03-16
                                            //you can implement different kind of Date Format here according to your requirement
                                            setState(() {
                                              datePublic.text =
                                                  formattedDate; //set output date to TextField value.
                                            });
                                          } else {
                                            print(
                                                "Public release Date is not selected");
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
                                          timePublic, //editing controller of this TextField
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          icon: Icon(
                                              Icons.timer), //icon of text field
                                          labelText:
                                              "Enter Public Time" //label text of field
                                          ),
                                      readOnly:
                                          true, //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          initialTime: TimeOfDay.now(),
                                          context: context,
                                        );

                                        if (pickedTime != null) {
                                          print(pickedTime.format(context));
                                          setState(() {
                                            timePublic.text = pickedTime
                                                .format(context)
                                                .toString();
                                            //formattedTime; //set the value of text field.
                                          });
                                        } else {
                                          print("Public Time is not selected");
                                        }
                                      },
                                    ))
                                  ],
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          ),
                        ],
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
