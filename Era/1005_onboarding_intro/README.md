# onboarding_intro

앱 인트로페이지 암기코딩

## 결과물

 ![onboarding](onboarding.apng)



## Youtube

[Flutter UI Tutorial | App Intro With Indicators Application UI/UX Design](https://www.youtube.com/watch?v=d_hQoKomfdE)



## Lesson learned

* PageView.builder, Stack
* List.generated, ...(Spread 연산자)



## Sinppets

* AppBar를 투명하게 만들고 본문이 AppBar뒤로 확장되도록 하기
```dart
AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  extendBodyBehindAppBar: true,
)
```

