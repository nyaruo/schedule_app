import 'package:flutter/material.dart';
import 'package:schedule_app/Calendar.dart';

class ReportPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: reportPage(),
    );
  }
}

class reportPage extends StatefulWidget {
  @override
  _reportPageState createState() => _reportPageState();
}

class _reportPageState extends State<reportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: schedule_calendar(),
    );
  }
}

