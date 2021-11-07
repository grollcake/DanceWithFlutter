# MyFirstCalendar
기존 낚시어플 플러터 포팅을 위한 캘린더 제작 연습

## 결과물

 ![calendar.apng](calendar.apng)


## 배운 것들

* 위젯:
1. Column의 child로 GridView를 사용하게 되면 'RenderBox was not laid out' 오류발생.
   GridView의 속성에 shrinkWrap: true 속성을 주면 해결됨.
   Expanded 위젯을 사용해도 됨. 상황에 맞게 사용하면 될 듯.

2. Container의 color속성과 decoration 속성 안에서의 컬러를 동시에 사용할 수 없음.

* 클래스 : DateTime