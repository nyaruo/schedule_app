import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Calendar.dart';
import '../task.dart';
import 'AddTaskPage.dart';
import 'ReportPage.dart';
import 'TaskListPage.dart';

class TopPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: topPage(),
    );
  }
}

class topPage extends StatefulWidget {
  @override
  _topPageState createState() => _topPageState();
}

class _topPageState extends State<topPage> {
  bool _validate = false;

  @override
  DateTime _focusedDay = DateTime.now();  //現在の日付
  DateTime? _selectedDay; //選択した日付
  CalendarFormat _calendarFormat = CalendarFormat.month;  //カレ
  String filterType = "today";
  DateTime today = new DateTime.now();

  var monthNames = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEPT",
    "OCT",
    "NOV",
    "DEC"
  ];

  //List<Task>: Taskオブジェクトのみを格納するリストを作成
  List<Task> tasks = [];

  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController memoCtrl = TextEditingController();

  /* widget　処理関数 */

  String createDateFormat(now) {
    var formatter = DateFormat('yyyy/MM/dd/HH:mm');
    String formatted = formatter.format(now);
    return formatted;
  }

  void addListItem(String text) {
    _validate = false;
    final Task newItem = Task(
        title: text,
        setDate: createDateFormat(DateTime.now()),
    );
//tasksの0番目に新しいタスクを追加
    tasks.insert(0, newItem);
// Controllerの内容を消去する
    titleCtrl.clear();
    memoCtrl.clear();
// SetStateを行うことによってWidgetの内容を更新
    setState(() {});
  }

//タスクの削除を行う処理
  void removeListItem(Task task) async {
    setState(() => tasks.remove(task));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Color(0xff50d4d9),
                elevation: 0,
                title: Text(
                  "Schedule Board", style: TextStyle(
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.6),
                ),
                ),
              ),
              Container(
                height: 50,
                color: Color(0xff50d4d9),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            changeFilter("today");
                          },
                          child: Text(
                            "Today",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 4,
                          width: 130,
                          color: (filterType == "today") ? Colors.white:Colors.transparent,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            changeFilter("monthly");
                          },
                          child: Text(
                            "Monthly",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 4,
                          width: 120,
                          color: (filterType == "monthly") ? Colors.white:Colors.transparent,
                        ),
                      ],
                    )
                  ],
                ),
              ),

              /* ここをCalendar.dartに置き換えたい */
              (filterType == "monthly") ? TableCalendar(
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
              ):Container(),
              // (filterType == "monthly") ? TableCalendar (
              //   firstDay: DateTime(2010),
              //   lastDay: DateTime(2030),
              //   focusedDay: today,
              //   startingDayOfWeek: StartingDayOfWeek.sunday,
              //   calendarFormat: CalendarFormat.month,
              // ) : Container(),


              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    if(index == 0) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${monthNames[_focusedDay.month - 1]}, ${_focusedDay.day}, ${_focusedDay.year}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container(
                      margin: EdgeInsets.all(10),
                      height: 100,
                      color: Color(0xff50d9b9).withOpacity(0.6),
                    );
                  },
                ),

                // child: SingleChildScrollView(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Container(
                //         padding: EdgeInsets.all(20),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               "${monthNames[_focusedDay.month - 1]}, ${_focusedDay.day}, ${_focusedDay.year}",
                //               style: TextStyle(
                //                 fontSize: 18,
                //                 color: Colors.grey,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       taskWidget(Color(0xfff96060).withOpacity(0.7), "task1", "9:00 AM"),
                //       taskWidget(Colors.blue.withOpacity(0.7), "task2", "9:00 AM"),
                //       taskWidget(Colors.green.withOpacity(0.7), "task3", "9:00 AM"),
                //     ],
                //   ),
                // ),
              ),
              Container(
                height: 110,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 106,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xd84ab3a6),
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.content_paste,
                                      color: Colors.white,),
                                    onPressed: openTaskListPage,
                                  ),
                                  Text(
                                    "Task",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 65,
                            ),

                            Container(
                              child: Column(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.check_circle_outlined,
                                    color: Colors.white,),
                                    onPressed: openReportPage,
                                  ),

                                  Text(
                                    "Report",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 25,
                      left: 0,
                      right: 0,
                      child: InkWell(
                        child: Container(
                          height: 60,
                          width: 50,
                          decoration: BoxDecoration(
                            /* LinearGradient: グラデーション */
                            gradient: LinearGradient(
                              /* topRight: 右上から */
                              begin: Alignment.topRight,
                              /* bottomLeft: 左下へ */
                              end: Alignment.bottomLeft,
                              colors: [Color(0xfff96060), Colors.red],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: TextButton(child: Text("＋",
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),onPressed: openNewTaskPage,),

                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  changeFilter(String filter) {
    filterType = filter;
    setState(() {});
  }

  Slidable taskWidget(int index, Color color, String title, String time) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.3,
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            /* offset: ウィジェットの位置 */
            offset: Offset(0, 10),
            /* blurRadius: 不透明度 */
            blurRadius: 20,
            /* spreadRadius: 要素の範囲が広がる */
            spreadRadius: 1,
          )
        ]),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                /* BoxShape.circle: 円形 */
                shape: BoxShape.circle,
                /* border: 枠線 */
                border: Border.all(
                  color: color,
                  width: 4,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              height: 50,
              width: 5,
              color: color,
            )
          ],
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: "Edit",
          color: Colors.white,
          icon: Icons.edit,
          onTap: openNewTaskPage,
        ),
        IconSlideAction(
          caption: "Delete",
          /* .withOpacity: 不透明度(0~1) */
          color: color.withOpacity(0.8),
          icon: Icons.edit,
          onTap: openReportPage,
        ),
      ],
    );
  }

  openNewTaskPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskPage()));
  }

  openReportPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportPage()));
  }
  openTaskListPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskListPage()));
  }
}


