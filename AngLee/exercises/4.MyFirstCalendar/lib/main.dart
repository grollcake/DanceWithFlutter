import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _dateHeader = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
  List<DateInfo> _dateInfoList = [];

  DateTime _date = DateTime.now();

  void _drawCalendar() {
    _dateInfoList = [];

    setState(() {


      // 오늘 날짜 객체 설정
      _date = DateTime(_date.year, _date.month, 1);

      var startDay = _date.weekday;
      var maxDay = DateTime(_date.year, _date.month+1, 0).day;

      if(startDay == 7){
        startDay = 0;
      }

      int needAddDay = 0;

      print('year ${_date.year} month ${_date.month} day ${_date.day}');

      print(_date.year);
      print(_date.month);
      print(startDay);
      print(maxDay);

      for (var i = 1; i < startDay + maxDay + 1; i++) {
        var dateInfo = DateInfo();

        if (i < startDay + 1) {
          dateInfo.isBlank = true;
        } else {
          var day = i - startDay;
          var calDate = DateTime(_date.year, _date.month, day);

          if(day == maxDay) {
            needAddDay = calDate.weekday;
          }
          dateInfo.day = day;
          dateInfo.dayOfWeek = calDate.weekday;
        }

        _dateInfoList.add(dateInfo);
      }

      // 남은 달력 칸 채우기
      if(needAddDay == 7){
        needAddDay = 6;
      } else {
        needAddDay = 6 - needAddDay;
      }

      for(var i=0; i<needAddDay; i++){
        var blankDate = DateInfo();
        blankDate.isBlank = true;
        _dateInfoList.add(blankDate);
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    _drawCalendar();

    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
            title: Text('First Tide Calendar'),
            titleTextStyle:
                TextStyle(fontWeight: FontWeight.w300, fontSize: 22),
            elevation: 0),
        preferredSize: Size.fromHeight(40),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: IconButton(
                    icon: Icon(Icons.navigate_before, size: 40),
                    onPressed: (){
                      setState(() {
                        _date = DateTime(_date.year, _date.month-1, 1);
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Center(
                    child: Text(
                      '${_date.year}. ${_date.month}.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    icon: Icon(Icons.navigate_next, size: 40),
                    onPressed: (){
                      setState(() {
                        _date = DateTime(_date.year, _date.month+1, 1);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height:10),
          GridView.builder(
              shrinkWrap: true,
              itemCount: _dateHeader.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.black45))),
                  child: Center(
                    child: Text(
                      _dateHeader[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: index == 0
                              ? Colors.red
                              : index == 6
                                  ? Colors.blue
                                  : Colors.black87),
                    ),
                  ),
                );
              }),
          GridView.builder(
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
              itemCount: _dateInfoList.length,
              itemBuilder: (context, index) {
                var thisDate = _dateInfoList[index];

                if (!thisDate.isBlank) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueGrey, width: 0.2)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _dateInfoList[index].day.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: thisDate.dayOfWeek == 7
                                    ? Colors.red
                                    : thisDate.dayOfWeek == 6
                                        ? Colors.blue
                                        : Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueGrey, width: 0.2)),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}

class DateInfo {
  bool isBlank = false;

  var day;
  var dayOfWeek;
}
