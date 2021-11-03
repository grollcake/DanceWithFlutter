import 'package:ex_211021_sqlite_test/db_helper.dart';
import 'package:ex_211021_sqlite_test/user.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'SQLITE DEMO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var id;
    var name;
    int age = 0;

    print('build');
    // _dbHelper.insertUser('jack', '이용제', 35);

    Future<List<User>> userList = _dbHelper.getUserList();

    void _test() {
      // userList.then((value) {
      //   value.forEach((element) {
      //     print(element.name);
      //   });
      // });
      // _dbHelper.insertUser('jack', '이용제', 35);

      print(id);
      print(name);
    }

    void _addUsers() async{
      await _dbHelper.insertUser(id, name, age);
      setState(() {
        userList = _dbHelper.getUserList();
      });
    }

    void _deleteUsers(int idx) {
      setState(() {
        _dbHelper.deleteUser(idx);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 50,
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    onChanged: (text) {
                      id = text;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'ID',
                      hintStyle: TextStyle(
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.teal)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.teal)),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 50,
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    onChanged: (text) {
                      name = text;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: '이름',
                      hintStyle: TextStyle(
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.teal)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.teal)),
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  height: 50,
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    onChanged: (text) {
                      age = int.parse(text);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: '나이',
                      hintStyle: TextStyle(
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.teal)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.teal)),
                    ),
                  ),
                ),
                MaterialButton(
                  minWidth: 70,
                  onPressed: _addUsers,
                  child: const Icon(Icons.add),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  color: Colors.blueGrey,

                )
              ],
            ),
            FutureBuilder(
              future: userList,
              builder: (context, snapshot){
                List<Widget> children;
                List<User> users;

                print('데이터 변화가 감지되었다.');

                if(snapshot.hasData){
                  print('SNAPSHOT 데이터가 존재한다');
                  users = snapshot.data as List<User>;
                  print('사이즈는 ${users.length}');

                } else {
                  print('데이터 없다');
                  users = [];
                }

                if(users.length == 0){
                  return Center(
                    child: Text('데이터 없음'),
                  );
                } else {
                  return Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (ctx, idx){

                        print('ListView Builder는 $idx 만큼 child를 만든다.');

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('${users[idx].id}(${users[idx].name}) ${users[idx].age}'),
                              ),
                            ),
                            MaterialButton(
                                minWidth: 50,
                                child: const Icon(Icons.remove),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.blueGrey,
                                onPressed: () => _deleteUsers(users[idx].idx)
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _test,
      //   tooltip: 'BTN',
      //   child: Icon(Icons.accessibility),
      // ),
    );
  }
}