// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
class GenesTableTab extends StatefulWidget {
  GenesTableTab({
    Key? key,
     this.title,
  }) : super(key: key);

  final String? title;

  @override
  _GenesTableTabState createState() => _GenesTableTabState();
}

class _GenesTableTabState extends State<GenesTableTab> {
  late Uint8List uploadedCsv;
  late String option1Text;

  _startFilePicker() async {
    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files!.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            uploadedCsv = Base64Decoder()
                .convert(reader.result.toString().split(",").last);
            print(utf8.decode(uploadedCsv));
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            option1Text = "Some Error occured while reading the file";
          });
        });

        reader.readAsDataUrl(file);
      }
    });
  }

  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            uploadedCsv == null
                ? Container()
                : Text(String.fromCharCodes(uploadedCsv)),
            uploadedCsv == null
                ? Container()
                : Text(utf8.decode(uploadedCsv)),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startFilePicker,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}