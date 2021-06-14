import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'TopPage.dart';

const MaterialColor customSwatch = const MaterialColor(
  0xff50d4d9,
  const<int, Color>{
    50: const Color(0xff50d9b9),
    100: const Color(0xffc5cae9),
    200: const Color(0xff9fa8da),
    300: const Color(0xff7986cb),
    400: const Color(0xff5c6bc0),
    500: const Color(0xff3f51b5),
    600: const Color(0xff3949ab),
    700: const Color(0xff303f9f),
    800: const Color(0xff283593),
    900: const Color(0xff1a237e),
  },
);

class AddTaskPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      home: addTaskPage(),
    );
  }
}

class addTaskPage extends StatefulWidget {


  @override
  _addTaskPageState createState() => _addTaskPageState();
}

class _addTaskPageState extends State<addTaskPage> {

  DateTime _date = new DateTime.now();

  /* ここまで */

  /* Datepicker */
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime.now().add(new Duration(days: 360))
    );
    if (picked != null) setState(() => _date = picked);
  }

  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController memoCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff50d4d9),
        elevation: 0,
        title: Text(
          "New Task",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TopPage()));
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.85,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /* Title */
                          Text(
                            "Project Name",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.grey.withOpacity(0.2),
                            child: TextField(
                              controller: titleCtrl,
                              decoration: InputDecoration(
                                hintText: "Title",
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          /* Description */
                          Text(
                            "Memo",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 150,
                            /* double.infinity: max幅に合わせる */
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              ),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                            padding: EdgeInsets.only(left:20, top:10,),
                            child: TextField(
                              controller: memoCtrl,
                              maxLines: 6,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "  Add Text...",
                              ),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.attach_file,
                                      color: Colors.grey,
                                    ), onPressed: () {  },
                                  ),
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          /* Deadline */
                          Text(
                            "Deadline",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  height: 50,
                                  width: 80,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  height: 40,
                                  width: 120,
                                  color: Colors.grey.withOpacity(0.2),
                                  child: new Text("   ${_date.year} / ${_date.month} / ${_date.day}"),

                                 ),
                                Container(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.date_range_outlined,
                                      color: Colors.grey,
                                    ), onPressed: () {
                                    _selectDate(context);
                                  },
                                  ),
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          /* Color */
                          Text(
                            "Color",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xfff96060).withOpacity(0.7),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.deepOrange.withOpacity(0.7),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.amber.withOpacity(0.7),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green.withOpacity(0.7),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                  color: Color(0xffff96060)),
                              child: Center(
                                child: TextButton(
                                child: Text(
                                  "Add Task",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),),
                                  onPressed: () {
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => TopPage()));
                                  },
                                ),
                              ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

