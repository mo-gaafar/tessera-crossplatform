import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';

class NewEventDescription extends StatelessWidget {
  const NewEventDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: const [
              Divider(
                color: Colors.green,
                thickness: 3,
                endIndent: 300,
              ),
              Text(
                'Describe your event.',
                style: TextStyle(fontSize: 40.0, fontFamily: 'NeuePlak'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Text(
                  'Enter a brief summary of your event so guests know what to expect',
                  style: TextStyle(fontSize: 20.0, fontFamily: 'NeuePlak'),
                  textAlign: TextAlign.left,
                ),
              ),
              TextField(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/neweventsetdate');
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
