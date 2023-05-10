import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/organizers_view/dashboard/cubit/dashboard_cubit.dart';
import 'package:tessera/features/organizers_view/ticketing/cubit/event_tickets_cubit.dart';
import 'package:tessera/features/organizers_view/ticketing/cubit/publish_cubit.dart';
import 'package:tessera/features/organizers_view/ticketing/data/publish_data.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_cubit.dart';
import '../../../../../core/services/validation/form_validator.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';

String changetoIso(String time, String date) {
  if ((time == '') && (date == '')) {
    DateTime now = DateTime.now();
    String formattedDate = now.toUtc().toIso8601String();
    return formattedDate;
  } else {
    String originalDateString = time + ' ' + date;
    DateTime originalDateTime =
        DateFormat('h:mm a yyyy-MM-dd').parse(originalDateString);
    String isoDateTimeString = originalDateTime.toUtc().toIso8601String();
    return isoDateTimeString;
  }
}

class PublishPage extends StatefulWidget {
  const PublishPage({super.key,required this.id});
  final String id;

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  late String privacy = ''; //event is public or private
  late String publicly = ''; //will ever be public later
  late String Schedule = ''; //publish now or later
  late bool isPublic;
  late bool publishNow;
  late bool link = true;
  late bool password = false;
  late bool alwaysPrivate;
  late bool chosen;
  TextEditingController datePublish = TextEditingController();
  TextEditingController timePublish = TextEditingController();
  TextEditingController datePublic = TextEditingController();
  TextEditingController timePublic = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FormValidator formValidator = FormValidator();
  late String genPassward = '';
  String dropdownValue = 'Anyone with the Link';

  @override
  void initState() {
    datePublic.text = '';
    timePublic.text = '';

    datePublish.text = '';
    timePublish.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: TextButton(
          onPressed: () async {
            //id = context.read<CreateEventCubit>().currentEvent.eventID!;
            //to  publishing
            if (Schedule == '') {
              publishNow = false;
            }

            if (publicly == '') {
              alwaysPrivate = false;
            }

            if ((dropdownValue == 'Anyone with the Link') &&
                (privacy == 'Public')) {
              link = false;
              password = false;
            }

            if (chosen == true && privacy == 'Public') {
              List data = await context.read<PublishCubit>().publish(
                  widget.id,
                  PublishModel(
                          alwaysPrivate: alwaysPrivate,
                          link: link,
                          isPublic: isPublic,
                          password: password,
                          publicDate:
                              changetoIso(timePublish.text, datePublish.text),
                          publishNow: publishNow)
                      .toMap(),
                  context.read<AuthCubit>().currentUser.accessToken!);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 2),
                // ignore: prefer_interpolation_to_compose_strings
                content: Text(data[0] as String),
                shape: StadiumBorder(),
                behavior: SnackBarBehavior.floating,
              ));
              context.read<DashboardCubit>().eventId = widget.id;
              Navigator.pushNamed(context, '/dashboard');
            } else if (chosen == true &&
                privacy == 'Private' &&
                publicly == 'Yes') {
              if (dropdownValue == 'Anyone with the Link') {
                List data = await context.read<PublishCubit>().publish(
                    widget.id,
                    PublishModel(
                            alwaysPrivate: alwaysPrivate,
                            link: link,
                            isPublic: isPublic,
                            password: password,
                            privateToPublicDate:
                                changetoIso(timePublic.text, datePublic.text),
                            publishNow: publishNow)
                        .toMap(),
                    context.read<AuthCubit>().currentUser.accessToken!);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 2),
                  // ignore: prefer_interpolation_to_compose_strings
                  content: Text(data[0] as String),
                  shape: StadiumBorder(),
                  behavior: SnackBarBehavior.floating,
                ));
                context.read<DashboardCubit>().eventId = widget.id;

                Navigator.pushNamed(context, '/dashboard');
              } else {
                if (formKey.currentState!.validate()) {
                  List data = await context.read<PublishCubit>().publish(
                      widget.id,
                      PublishModel(
                              alwaysPrivate: alwaysPrivate,
                              link: link,
                              isPublic: isPublic,
                              password: password,
                              privateToPublicDate:
                                  changetoIso(timePublic.text, datePublic.text),
                              publishNow: publishNow,
                              generatedPassword: genPassward)
                          .toMap(),
                      context.read<AuthCubit>().currentUser.accessToken!);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 2),
                    // ignore: prefer_interpolation_to_compose_strings
                    content: Text(data[0] as String),
                    shape: StadiumBorder(),
                    behavior: SnackBarBehavior.floating,
                  ));
                  context.read<DashboardCubit>().eventId = widget.id;

                  Navigator.pushNamed(context, '/dashboard');
                }
              }
            } else if (chosen == true &&
                privacy == 'Private' &&
                publicly == 'No') {
              if (dropdownValue == 'Anyone with the Link') {
                List data = await context.read<PublishCubit>().publish(
                    widget.id,
                    PublishModel(
                            alwaysPrivate: alwaysPrivate,
                            link: link,
                            isPublic: isPublic,
                            password: password,
                            publishNow: publishNow)
                        .toMap(),
                    context.read<AuthCubit>().currentUser.accessToken!);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 2),
                  // ignore: prefer_interpolation_to_compose_strings
                  content: Text(data[0] as String),
                  shape: StadiumBorder(),
                  behavior: SnackBarBehavior.floating,
                ));
                context.read<DashboardCubit>().eventId = widget.id;

                Navigator.pushNamed(context, '/dashboard');
              } else {
                if (formKey.currentState!.validate()) {
                  List data = await context.read<PublishCubit>().publish(
                      widget.id,
                      PublishModel(
                              alwaysPrivate: alwaysPrivate,
                              link: link,
                              isPublic: isPublic,
                              password: password,
                              publishNow: publishNow,
                              generatedPassword: genPassward)
                          .toMap(),
                      context.read<AuthCubit>().currentUser.accessToken!);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 2),
                    // ignore: prefer_interpolation_to_compose_strings
                    content: Text(data[0] as String),
                    shape: StadiumBorder(),
                    behavior: SnackBarBehavior.floating,
                  ));
                  context.read<DashboardCubit>().eventId = widget.id;

                  Navigator.pushNamed(context, '/dashboard');
                }
              }
            }
          },
          child: Text(
            'Publish',
            style: TextStyle(
                fontFamily: 'NeuePlak',
                color: Theme.of(context).colorScheme.onTertiaryContainer,
                fontSize: 25),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Publishing',
          textAlign: TextAlign.left,
          style: TextStyle(fontFamily: 'NeuePlak', fontSize: 25),
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
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
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
                            publicly = '';
                            datePublic.text = '';
                            timePublic.text = '';
                            genPassward = '';
                            isPublic = true;
                            chosen = true;
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
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
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
                            isPublic = false;
                            chosen = true;
                            Schedule = ''; //publish now or later
                            datePublish.text = '';
                            timePublish.text = '';

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
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .onTertiaryContainer,
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
                                      publishNow = true;
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiaryContainer,
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
                                      publishNow = false;
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiaryContainer,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                          BlocBuilder<EventTicketsCubit, EventTicketsState>(
                            builder: (context, state) {
                              if ((state is EventPublishLater) ||
                                  (state is EventPublic &&
                                      (Schedule == 'Later'))) {
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
                                            //pickedDate output format => 2021-03-10 00:00:00.000
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
                                            //formatted date output using intl package =>  2021-03-16
                                            //you can implement different kind of Date Format here according to your requirement
                                            setState(() {
                                              datePublish.text =
                                                  formattedDate; //set output date to TextField value.
                                            });
                                          } else {}
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
                                          setState(() {
                                            timePublish.text = pickedTime
                                                .format(context)
                                                .toString();
                                            //formattedTime; //set the value of text field.
                                          });
                                        } else {}
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
                        state is EventAccessWithPasswordAndBecamePublic ||
                        state is EventAccessWithLinkAndBecamePublic ||
                        state is EventAccessWithPasswordAndKeptPrivate ||
                        state is EventAccessWithLinkAndKeptPrivate) {
                      return Column(
                        children: [
                          Text(
                            'Choose Your Audiance',
                            style: TextStyle(
                                fontFamily: 'NeuePlak',
                                color: Theme.of(context)
                                    .colorScheme
                                    .onTertiaryContainer,
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
                                  link = true;
                                  password = false;
                                  context
                                      .read<EventTicketsCubit>()
                                      .EventIsPrivateAndWithLink();
                                } else if (dropdownValue ==
                                    'Only People With Passward') {
                                  link = false;
                                  password = true;
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
                                  state
                                      is EventAccessWithPasswordAndKeptPrivate) {
                                return TextFormField(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Password *',
                                      helperText: 'Required'),
                                  validator: (value) {
                                    password = true;
                                    genPassward = value!;
                                    if (genPassward.trim().isEmpty) {
                                      return 'Password is required.';
                                    }
                                    return null;
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .onTertiaryContainer,
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
                                      alwaysPrivate = true;
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiaryContainer,
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
                                      alwaysPrivate = false;
                                      if (dropdownValue ==
                                          'Anyone with the Link') {
                                        context
                                            .read<EventTicketsCubit>()
                                            .EventBecamePublicAndWithLink();
                                      } else if (dropdownValue ==
                                          'Only People With Passward') {
                                        context
                                            .read<EventTicketsCubit>()
                                            .EventBecamePublicAndWithPassward();
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiaryContainer,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                          BlocBuilder<EventTicketsCubit, EventTicketsState>(
                            builder: (context, state) {
                              if ((state
                                      is EventAccessWithPasswordAndBecamePublic) ||
                                  (state
                                      is EventAccessWithLinkAndBecamePublic) ||
                                  ((state is EventAccessWithLink ||
                                          state is EventAccessWithPassword ||
                                          state is EventPrivate) &&
                                      (publicly == 'Yes'))) {
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
                                            //pickedDate output format => 2021-03-10 00:00:00.000
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
                                            //formatted date output using intl package =>  2021-03-16
                                            //you can implement different kind of Date Format here according to your requirement
                                            setState(() {
                                              datePublic.text =
                                                  formattedDate; //set output date to TextField value.
                                            });
                                          } else {}
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
                                          setState(() {
                                            timePublic.text = pickedTime
                                                .format(context)
                                                .toString();
                                            //formattedTime; //set the value of text field.
                                          });
                                        } else {}
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
