import 'dart:async';
import 'package:flutter/material.dart';
import 'package:schedule_app/pages/TopPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff50d4d9),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), openCalendarPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xff50d4d9), width: 8,),
          ),
            child: Center(
              child: Text(
                "image", style: TextStyle(
                fontSize: 50,
                color: Color(0xff50d4d9),
              ),
              ),
            ),
        ),
          ),
    );
  }

  void openCalendarPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TopPage()));
  }
}
