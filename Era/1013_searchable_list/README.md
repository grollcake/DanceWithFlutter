# 검색 가능한 리스트2

실시간 검색이 되는 리스트뷰 2번째 암기코딩

## 결과물



## Youtube

[Flutter Searchable ListView - Day 28](https://www.youtube.com/watch?v=9PWaRfYZ6Lg)



## Lesson learned

* Column 안에 ListView를 쓸때는 Expanded로 감싸야한다.



## Sinppets

* 조건에 맞는 리스트 아이템만 추출하여 새로운 리스트로 저장
```dart
_searchedUsers = _allUsers.where((user) => user.name.toLowerCase().contains(keyword.toLowerCase())).toList();
```

