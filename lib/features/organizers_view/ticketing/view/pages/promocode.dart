import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/core/services/validation/form_validator.dart';
import 'package:tessera/features/organizers_view/ticketing/cubit/promocode_cubit.dart';

import '../../cubit/event_tickets_cubit.dart';
import '../../cubit/promocode_store_cubit.dart';
import '../../data/promocode_data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class PromoCode extends StatefulWidget {
  const PromoCode({super.key});

  @override
  State<PromoCode> createState() => _PromoCodeState();
}

class _PromoCodeState extends State<PromoCode> {
  String id = '6456c9d351ed139b0a9d71b2';
  final formKey = GlobalKey<FormState>();
  String dropdownValue = 'Add Promo code';
  late String code ;
  late String discount ;
  late String limitOfUses ;
  FormValidator formValidator = FormValidator();
  
  Future<List> loadCSV() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['csv', 'xlsx']);
    final file = result!.files.single.path;
    final filefinal = File(file!);
    final input = await filefinal.readAsString();
    const converter = CsvToListConverter();
    final List<List<dynamic>> csvList = converter.convert(input);
    
    return csvList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: TextButton(
            onPressed: () async {
              //to  publishing
              //Navigator.pushNamed(context, '/publishPage');
              if (formKey.currentState!.validate())  {
                  
                       String message = await context.read<PromocodeCubit>().addPromocode(id,PromocodeModel(code: code, discount: int.parse(discount), limitOfUses: int.parse(limitOfUses))
                      .toMap());
                      if (message== 'successfully added')
                      {
                        ScaffoldMessenger.of(context)
                            .showSnackBar( SnackBar(
                          duration: Duration(seconds: 2),
                          // ignore: prefer_interpolation_to_compose_strings
                          content:
                              Text('go to admissiom'),
                          shape: StadiumBorder(),
                          behavior:
                              SnackBarBehavior.floating,
                        ));
                      }
                      else
                      {
                           ScaffoldMessenger.of(context)
                            .showSnackBar( SnackBar(
                          duration: Duration(seconds: 2),
                          // ignore: prefer_interpolation_to_compose_strings
                          content:
                              Text(message as String),
                          shape: StadiumBorder(),
                          behavior:
                              SnackBarBehavior.floating,
                        ));

                      }
                 
                }
            },
            child: Text(
              'Save',
              style: TextStyle(
                  fontFamily: 'NeuePlak',
                  color: AppColors.secondaryTextOnLight,
                  fontSize: 25),
            ),
          ),
        ),
        body: SafeArea(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                      child: Column(children: [
              DropdownButton<String>(
                // Step 3.
                value: dropdownValue,
                // Step 4.
                items: <String>['Add Promo code', 'upload promo code']
                    .map<DropdownMenuItem<String>>((String value) {
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
                    if (dropdownValue == 'Add Promo code') {
                      context.read<EventTicketsCubit>().TicketaddPromocode();
                    } else if (dropdownValue == 'upload promo code') {
                      context.read<EventTicketsCubit>().TicketuploadPromocode();
                    }
                  });
                },
              ),
              BlocBuilder<EventTicketsCubit, EventTicketsState>(
                builder: (context, state) {
                  if (state is TicketUploadPromocode) {
                    return TextButton(
                      onPressed: () {
                        Future<List> csv = loadCSV();
                      },
                      child: Text(
                        'upload promocode',
                        style: TextStyle(
                            fontFamily: 'NeuePlak',
                            color: AppColors.secondaryTextOnLight,
                            fontSize: 25),
                      ),
                    );
                  } else if (state is TicketAddPromocode) {
                    return Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'code *',
                              helperText: 'discount'),
                          validator: (value) {
                            code = value!;
                            if (code.trim().isEmpty) {
                              return 'code is required.';
                            }
                            return formValidator.nameValidty(code); //not more than 50 characters
                          },
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'discount*',
                              helperText: 'Required'),
                          validator: (value) {
                            discount = value!;
                            if (discount.trim().isEmpty) {
                              return 'discount is required.';
                            }
                            return formValidator.numberValidty(discount); //not more than 50 characters
                          },
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'limitOfUses*',
                              helperText: 'Required'),
                          validator: (value) {
                            limitOfUses = value!;
                            if (limitOfUses.trim().isEmpty) {
                              return 'limitOfUses is required.';
                            }
                            return formValidator.numberValidty(limitOfUses); //not more than 50 characters
                          },
                        ),
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
                      ]),
                    ),
            )));
  }
}
