# BMI 계산기

2개의 페이지로 구성된 BMI 계산기

## 결과물

 ![preview](preview.png)



## Design resource

[Simple BMI Calculator from dribbble](https://dribbble.com/shots/4585382-Simple-BMI-Calculator)

## Lesson learned

* RawMaterialButton
* routes, initialRoute, Navigator.pushNamed
* Drawer, DrawerHeader
* Package: Fluttertoast
* Package: FontAwesome
* Package: url_launcher
* 커스텀 아이콘 제작

## Sinppets

named route를 사용할 때 인자 전달

```dart
// 호출 쪽
Navigator.pushNamed(context, '/result', arguments: UserInfo(height: height, weight: weight));

// 받는 쪽
userInfo = ModalRoute.of(context)!.settings.arguments as UserInfo;
```

안드로이드에서 WebView를 사용하기 위해서는 `AndroidManifest.xml` 에 아래 내용 추가

파일명: `app/src/main/AndroidManifest.xml`

```xml
<queries>
  <!-- If your app opens https URLs -->
  <intent>
    <action android:name="android.intent.action.VIEW" />
    <data android:scheme="https" />
  </intent>
</queries>
```



