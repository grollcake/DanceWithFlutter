import 'dart:io';

import 'package:ex_211021_sqlite_test/user.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DBHelper {

  var _db;

  Future<Database> get database async {
    if(_db != null) return _db;
    _db = openDatabase(
        join(await getDatabasesPath(), 'user_database.db'),
        onCreate: (db, version) {
          db.execute('CREATE TABLE users(idx INTEGER PRIMARY KEY, id TEXT, name TEXT, age INTEGER)');
        },
        version: 2
    );
    return _db;
  }
  
  Future<void> insertUser(String _id, String _name, int _age) async {
    final db = await database;
    int maxIdx = 0;

    // 최대 Key 값 가져오기. 정녕 이 방법밖에 없는것인가..
    await db.query('users', orderBy: 'idx DESC', limit: 1).then((value){
      if(value.length > 0){
        maxIdx = int.parse(value[0]['idx'].toString());
      }
    });

    print('원래 값 $maxIdx');

    maxIdx++;

    print('다음 값 $maxIdx');


    var user = User(idx: maxIdx, id: _id, name: _name, age: _age);
    await db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

  }
  
  Future<void> deleteUser(int _idx) async {
    final db = await database;
    db.delete('users', where: 'idx = ?', whereArgs: [_idx]);
  }

  Future<List<User>> getUserList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (index) => User(
      idx: maps[index]['idx'],
      id: maps[index]['id'],
      name: maps[index]['name'],
      age: maps[index]['age'],
    ));
  }




}