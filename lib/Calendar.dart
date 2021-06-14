import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class schedule_calendar extends StatefulWidget {
  @override
  _schedule_calendarState createState() => _schedule_calendarState();
}

class _schedule_calendarState extends State<schedule_calendar> {
  @override
  DateTime _focusedDay = DateTime.now();  //現在の日付
  DateTime? _selectedDay; //選択した日付
  CalendarFormat _calendarFormat = CalendarFormat.month;  //カレンダーの表示形式

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Calendarboard'),
      //     backgroundColor: Color(0xff50d4d9),
      // ),
      body: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              /* 指定した曜日を選択できなくする */
              // selectedDayPredicate: (DateTime val) => val.weekday == 6 || val.weekday == 7 ? false : true,
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,

              /* onFormatChanged: カレンダーの表示形式を変更 */
              onFormatChanged: (format) {
                if(_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },

              /* selectedDayPredicate: どの日付が選択されているか */
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },

              /* タップした日付に印をつける */
              onDaySelected: (selectedDay, focusedDay) {
                if(!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },

              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,

                todayTextStyle: TextStyle(color: Colors.black),
                /* todayDecoration: 現在の日付のハイライトスタイル */
                todayDecoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5), width: 2),
                ),

                /* selectedTextStyle: 選択した日付のテキストの色 */
                selectedTextStyle: TextStyle(color: Colors.black),
                  /* selectedDecoration: 選択した日付のハイライトスタイル */
                selectedDecoration: BoxDecoration(
                  color: Color(0xd84ab3a6).withOpacity(0.3),
                  shape: BoxShape.rectangle,
                ),

              ),
            )
          ]
        ),
    );
  }
}

