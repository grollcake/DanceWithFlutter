# memorized_calculator
계산기 코드에 사용된 위젯들 숙달 후 계산기 앱 만들기

## 결과물

 ![calc.apng](calc.apng)

## 유튜브

[FLUTTER CALCULATOR • 1 • UI](https://www.youtube.com/watch?v=dGVhhJg-QAo)

## 배운 것들

* 위젯: Expanded, Container, GridView, PreferredSize
* 패키지: 
    math_expressions, 
    fluttertoast(커스텀 메시지는 안드 11미만에서만 동작하는 것으로 추정.. 연구 필요)

## Snippet

* 정수 판단
```dart
  bool isInt(String str) {
  if (str == null) {
    return false;
  }
  return int.tryParse(str) != null;
}
```
* 실수 판단
```dart
bool isDouble(String str) {
  if (str == null) {
    return false;
  }
  return double.tryParse(str) != null;
}
```