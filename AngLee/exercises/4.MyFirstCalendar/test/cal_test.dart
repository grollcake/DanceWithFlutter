void main(){

  // 오늘 날짜 객체 설정
  var date = DateTime.now();
  date = DateTime(date.year, date.month, 1);

  print('month ' + date.month.toString());

  var thisYear = date.year;
  var thisMonth = date.month;
  var startDay = date.weekday;
  var maxDay = DateTime(thisYear, thisMonth, 0).day;

  print(startDay);
  print(date.day);

}

class DateInfo {

  bool isBlank = false;

  var day;
  var dayOfWeek;

}