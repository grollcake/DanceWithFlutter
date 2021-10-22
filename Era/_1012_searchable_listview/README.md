# 검색 가능한 리스트

실시간 검색이 되는 리스트뷰

## 결과물

 ![preview](preview.png)



## Youtube

[Flutter Searchable ListView - Day 28](https://www.youtube.com/watch?v=9PWaRfYZ6Lg)



## Lesson learned

* .where 메서드
* 리스트는 얉은 복사만 가능



## Sinppets

* 조건에 맞는 리스트 아이템만 추출하여 새로운 리스트로 저장
```dart
_searchedUsers = _allUsers.where((user) => user.name.toLowerCase().contains(keyword.toLowerCase())).toList();
```

