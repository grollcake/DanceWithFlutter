# alert_dialog

대화창 입력을 받는 간단한 경고창 실습

## 배운점
* 경고창에서 입력받은 것을 부모에게 돌려줄 때는 Navigator.of(context).pop(DATA) 형태로 사용
* 비동기로 결과값을 전달하기 때문에 Future<String?> 형태로 함수 구현 필요
* showDialog에 타입을 String으로 지정하고 return으로 결과 반환

```dart
  Future<String?> getUserName(context) {
    TextEditingController _controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Your name?'),
          content: Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: _controller,
              autofocus: true,
              onSubmitted: (userInput) => Navigator.of(context).pop(_controller.text),
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(_controller.text);
                },
                child: Text('Submit')),
          ],
        );
      },
    );
  }

```
