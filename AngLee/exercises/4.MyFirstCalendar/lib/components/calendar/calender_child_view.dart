import 'package:flutter/material.dart';
import 'package:my_first_calendar/model/date_info.dart';
import 'package:weather_icons/weather_icons.dart';

class CalenderChildView extends StatelessWidget {

  const CalenderChildView({Key? key, required this.dateInfo}) : super(key: key);
  final DateInfo dateInfo;

  @override
  Widget build(BuildContext context) {
    if (!dateInfo.isBlank) {
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
                dateInfo.day,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: dateInfo.dayOfWeek == 7
                        ? Colors.red
                        : dateInfo.dayOfWeek == 6
                        ? Colors.blue
                        : Colors.black87),
              ),
              dateInfo.hasWeatherInfo ? BoxedIcon(dateInfo.wIcons, size: 20) : Container()
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
  }
}
