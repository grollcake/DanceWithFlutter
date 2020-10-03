import 'package:ProviderApp4/service/list_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ListService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHome(),
      ),
    );
  }
}

class MyHome extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("Provider App"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Consumer(
              builder: (BuildContext context, ListService listService, child) {
                return Chip(label: Text(listService.listCount.toString()));
              },
            ),
          )
        ],
      ),
      body: Container(),
    );
  }
}

class FAB extends StatelessWidget {
  Widget build(BuildContext context) {
    
  }
}