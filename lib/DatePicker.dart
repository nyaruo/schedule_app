import 'package:flutter/material.dart';
import 'dart:async';

class datePicker extends StatefulWidget {
  @override
  _datePickerState createState() => _datePickerState();
}

class _datePickerState extends State<datePicker> {

  DateTime _date = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime.now().add(new Duration(days: 360))
    );
    if (picked != null) setState(() => _date = picked);
  }

  Widget build(BuildContext context) {
    return Container(
        height: 500,
        width: 300,
    );
  }
}
