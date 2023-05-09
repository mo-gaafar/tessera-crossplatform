import 'package:flutter/material.dart';
import 'package:numpad/numpad.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/atendee_management/cubit/atendeeManagement_cubit.dart';

class MyCustomizedNumpad extends StatefulWidget {
  String? priceOfTheTicketSelected;
  MyCustomizedNumpad({this.priceOfTheTicketSelected});

  @override
  State<MyCustomizedNumpad> createState() => _MyCustomizedNumpadState();
}

class _MyCustomizedNumpadState extends State<MyCustomizedNumpad> {
  String code = "0";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Select number of tickets'),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.done_outlined,
              ),
              onPressed: () {
                context
                    .read<AtendeeManagementCubit>()
                    .atendeeModel
                    .ticketQuantity = code;
                context
                        .read<AtendeeManagementCubit>()
                        .atendeeModel
                        .totalTicketsPrice =
                    (int.parse((code == null) ? '0' : code) *
                            double.parse(widget.priceOfTheTicketSelected!))
                        .toString();
                context.read<AtendeeManagementCubit>().updateAtendeeInfo(
                    ticketsTotalPrice: context
                        .read<AtendeeManagementCubit>()
                        .atendeeModel
                        .totalTicketsPrice);
                Navigator.pop(context);
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: const Icon(
                          Icons.remove,
                          size: 30,
                        ),
                        onTap: () {
                          setState(() {
                            if (code == '' || code == '0') {
                              code = '0';
                            } else {
                              code = (int.parse(code) - 1).toString();
                            }
                          });
                        },
                      ),
                      Text(
                        code,
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        child: const Icon(Icons.add, size: 30),
                        onTap: () {
                          setState(() {
                            if (code == '') {
                              code = '0';
                            }
                            code = (int.parse(code) + 1).toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                NumPad(
                  onTap: (val) {
                    if (val == 99) {
                      if (code.isNotEmpty) {
                        setState(() {
                          code = code.substring(0, code.length - 1);
                        });
                      }
                    } else {
                      setState(() {
                        if (code == '0') {
                          code = '';
                          code += "$val";
                        } else {
                          code += "$val";
                        }
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
