import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';

class NewEventReceipt extends StatelessWidget {
  const NewEventReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.visibility),
              tooltip: 'Show',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('This is a visibilty icon snackbar')));
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.done,
                color: Colors.grey,
              ),
              tooltip: 'Show',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('This is a done icon snackbar')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.publish_outlined),
              tooltip: 'Show',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('This is a publish icon snackbar')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              tooltip: 'Show',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('This is a more icon snackbar')));
              },
            ),
          ],
        ),
        body: const Center(
          child: Text(
            'This is the home page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
