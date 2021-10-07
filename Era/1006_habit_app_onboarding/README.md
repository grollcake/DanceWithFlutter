# Habit app onboarding intro

앱 인트로페이지 실습

## 미리보기

 ![preview](preview.apng)



## Youtube

[Flutter Onboarding Screen Tutorial | Habit App | speed code](https://youtu.be/iVFPKW1WTVQ)



## Lesson learned

* SharedPreferences 읽기/쓰기
* FutureBuilder
* 안드로이드 상단 상태바 보이기/숨기기
* 반응형 레이아웃



## Sinppets

* 안드로이드 상단 상태바 보이기/숨기기
```dart
SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);  // 숨기기
SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]); // 보이기
```

* 앱 내부 로컬스토리지 접근: `shared_preferences` 패키지 사용

```dart
// bool 형태의 'ONBOARDING_COMPLETE' 상태값 읽기
Future<bool> _seenOnboarding() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool status = prefs.getBool('ONBOARDING_COMPLETE') ?? false;
  await Future.delayed(Duration(seconds: 3));
  return status;
}
```

* 로컬 스토리지 상태값에 따른 초기화면

```dart
home: FutureBuilder(
    future: _seenOnboarding(),
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        print(snapshot.connectionState);
        switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
                return SplashScreen();
            case ConnectionState.done:
                return (snapshot.data ?? false) ? MainPage() : OnboardingScreen();
            default:
                return Container();
        }
    },
),
```

  
