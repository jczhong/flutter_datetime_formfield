import 'package:flutter/material.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';

class MyWidget extends StatelessWidget {
  final DateTime initialValue;
  final String label;

  MyWidget({Key key, @required this.initialValue, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      home: Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Center(
          child: DateTimeFormField(
            initialValue: initialValue,
            label: label,
          ),
        ),
      ),
    );
  }
}

