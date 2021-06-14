import 'package:flutter/material.dart';

class TaskListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: taskListPage(),
    );
  }
}

class taskListPage extends StatefulWidget {

  @override
  _taskListPageState createState() => _taskListPageState();
}

class _taskListPageState extends State<taskListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

