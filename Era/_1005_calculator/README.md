# calculator

암기코딩으로 계산기 앱 만들기

## 결과물

 ![Calculator](Calculator.apng)

## 유튜브

[FLUTTER CALCULATOR • 1 • UI](https://www.youtube.com/watch?v=dGVhhJg-QAo)

## 배운 것들

* 위젯: Expanded, TextButton, TextButton.styleFrom, Stack, Positioned
* 패키지: math_expressions
* 메서드: 배열에 요소가 있는지 확인하려면 .contains() 사용

## Snippet

* 수식 문자열을 계산하기

```dart
Parser p = Parser();
Expression exp = p.parse(eval.replaceAll('X', '*'));
double r = exp.evaluate(EvaluationType.REAL, ContextModel());
```

* 파라미터가 있는 콜백 넘기기


  ```dart
  final Function(String) onPressed;
  
  TextButton(
        onPressed: () => onPressed(btnText),
  ```





