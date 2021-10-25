# ex_211021_sqlite_test

2021.10.25. SQLite 테스트 - DB를 생성해서 사용해보기

## 결과물
![sqlite.apng](sqlite.apng)


## 배운 것들
1. openDatabase  
DB를 새로 만들거나 기존 db파일을 assets에 위치시켜 활용할 수 있다.
And Native와 마찬가지로 version관리를 할 수 있고, 버전이 변경되는 시점에 특정 쿼리를 실행 할 수 있다.

   
2. database.XXX   
dart의 sqlite는 query, insert, delete 등의 CRUD관련 메소드를 가진다.   
RAW쿼리를 수행할 수도 있고 객체를 넘기기도 하지만 Android의 ROOM처럼 ORM기반은 아닌 것으로 추측된다.
   

3. Future, Async, Await, Then   
어설프게나마 필요한 곳에 사용하였으나 성능상에 문제가 없는 지 확실치 않다.       
특히 성능상의 이점을 취하기 위해 async로 메소드를 실행하고    
await로 blocking을 시키는 것이 이해가 잘 되지 않는다.
해당 메소드 블록은 async처리 되고 UI는 블록되지 않으며 UI는 FutureBuilder가 데이터 변화를 감지하여
UI를 변화시키기 때문에 await가 되더라도 UI는 블록되지 않을 것으로 추측?된다     
예전에 알던 Android의 UI Thread와 연산 Thread의 관계와는 전혀 다른 생태계를 가지는 듯 하다.


4. 무슨 언어든 Reactive가 대세인듯!