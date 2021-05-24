import 'package:flutter/material.dart';
import 'package:schedule_app/calendar_view.dart';
import 'package:schedule_app/plan_view.dart';
import 'package:schedule_app/report_view.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    PlanView(),
    CalendarView(),
    ReportView(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Nav Bar'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            title: Text('Plan'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range_outlined),
            title: Text('Calendar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outlined),
            title: Text('Report'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
