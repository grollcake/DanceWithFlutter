import 'package:flutter/material.dart';
import 'package:my_first_calendar/components/calendar/calender_child_view.dart';
import 'package:my_first_calendar/model/weather_info.dart';
import 'package:weather_icons/weather_icons.dart';

import 'model/date_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState(weatherListStr: _getWeather());

  Future<String> _getWeather() async {

    final queryParams = {
      'nx': '60',
      'ny': '70',
      'locationCode': 'DT_0001',
      'loc': '목포'
    };

    var url = Uri.https('honeyangler.gtz.kr',
        '/fishingtoc/weather/getWeekData.php', queryParams);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    }

    return '';

  }

}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState({required this.weatherListStr});

  final List<String> _dateHeader = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
  List<DateInfo> _dateInfoList = [];
  Map<String, WeatherInfo> _weatherInfoMap = {};

  DateTime _date = DateTime.now();
  final Future<String> weatherListStr;

  void _drawCalendar() {
    _dateInfoList = [];

      // 오늘 날짜 객체 설정
      _date = DateTime(_date.year, _date.month, 1);

      var startDay = _date.weekday;
      var maxDay = DateTime(_date.year, _date.month + 1, 0).day;

      if (startDay == 7) {
        startDay = 0;
      }

      int needAddDay = 0;

      for (var i = 1; i < startDay + maxDay + 1; i++) {
        var dateInfo = DateInfo();

        if (i < startDay + 1) {
          dateInfo.isBlank = true;
        } else {
          var day = i - startDay;
          var calDate = DateTime(_date.year, _date.month, day);

          if (day == maxDay) {
            needAddDay = calDate.weekday;
          }

          dateInfo.year = _date.year.toString();
          dateInfo.month = _date.month.toString();
          dateInfo.day = day.toString();

          dateInfo.dayOfWeek = calDate.weekday;

          if(_weatherInfoMap.containsKey(dateInfo.getFullDate())){

            WeatherInfo? wInfo = _weatherInfoMap[dateInfo.getFullDate()];

            String simpleWeatherCode = wInfo!.weatherCode.toString().substring(0,1);
            dateInfo.hasWeatherInfo = true;


            if(simpleWeatherCode == '0'){
              dateInfo.wIcons = WeatherIcons.day_sunny;
            } else if(simpleWeatherCode == '1'){
              dateInfo.wIcons = WeatherIcons.day_rain;
            } else {
              dateInfo.wIcons = WeatherIcons.day_snow;
            }

          }


        }

        _dateInfoList.add(dateInfo);
      }

      // 남은 달력 칸 채우기
      if (needAddDay == 7) {
        needAddDay = 6;
      } else {
        needAddDay = 6 - needAddDay;
      }

      for (var i = 0; i < needAddDay; i++) {
        var blankDate = DateInfo();
        blankDate.isBlank = true;
        _dateInfoList.add(blankDate);
      }

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
            title: Text('FishingToc', textAlign: TextAlign.right,),
            titleTextStyle:
                TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
            elevation: 0),
        preferredSize: Size.fromHeight(24),
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
                    onPressed: () {
                      setState(() {
                        _date = DateTime(_date.year, _date.month - 1, 1);
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${_date.year}',
                          style:
                              TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${_date.month}',
                          style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    icon: Icon(Icons.navigate_next, size: 40),
                    onPressed: () {
                      setState(() {
                        _date = DateTime(_date.year, _date.month + 1, 1);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          GridView.builder(
              shrinkWrap: true,
              itemCount: _dateHeader.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
              itemBuilder: (context, index) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade100,
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
                  ),
                );
              }),
          FutureBuilder<String>(
            future: weatherListStr,
            builder: (context, snapshot){
              if(snapshot.hasData){

                // 날씨데이터 전달받고 날씨데이터 처리 후 위젯 그리기
                var jsonResponse = convert.jsonDecode(snapshot.data.toString()) as List<dynamic>;

                jsonResponse.forEach((element) {
                  var el = convert.jsonDecode(convert.jsonEncode(element));

                  String dateKey = el['tmEf'].toString().substring(0,10);
                  _weatherInfoMap[dateKey] = WeatherInfo(dateKey, el['code'].toString());

                });
                _drawCalendar();

                return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                    itemCount: _dateInfoList.length,
                    itemBuilder: (context, index) {
                      var thisDate = _dateInfoList[index];
                      return CalenderChildView(
                        dateInfo: thisDate);
                    });
              }
              return CircularProgressIndicator();
            }
          ),
        ],
      ),
    );
  }


}
