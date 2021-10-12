void main(){

  // 오늘 날짜 객체 설정
  var date = DateTime.now();
  date = DateTime(2021, 10, 1);
  var maxDay = DateTime(date.year, date.month+1, 0).day;

  print('year ${date.year} month ${date.month} day ${date.day} maxDay ${maxDay}');

  date = DateTime(2021, 11, 1);
  maxDay = DateTime(date.year, date.month+1, 0).day;

  print('year ${date.year} month ${date.month} day ${date.day} maxDay ${maxDay}');

  date = DateTime(2021, 12, 1);
  maxDay = DateTime(date.year, date.month+1, 0).day;

  print('year ${date.year} month ${date.month} day ${date.day} maxDay ${maxDay}');

  date = DateTime(2022, 1, 1);
  maxDay = DateTime(date.year, date.month+1, 0).day;

  print('year ${date.year} month ${date.month} day ${date.day} maxDay ${maxDay}');

  date = DateTime(2022, 2, 1);
  maxDay = DateTime(date.year, date.month+1, 0).day;

  print('year ${date.year} month ${date.month} day ${date.day} maxDay ${maxDay}');

  date = DateTime(2022, 3, 1);
  maxDay = DateTime(date.year, date.month+1, 0).day;

  print('year ${date.year} month ${date.month} day ${date.day} maxDay ${maxDay}');

  date = DateTime(2022, 4, 1);
  maxDay = DateTime(date.year, date.month+1, 0).day;

  print('year ${date.year} month ${date.month} day ${date.day} maxDay ${maxDay}');


}

class DateInfo {

  bool isBlank = false;

  var day;
  var dayOfWeek;

}