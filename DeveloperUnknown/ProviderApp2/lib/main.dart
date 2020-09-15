import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ProviderApp2/service/list_service.dart';

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
        title: Text("Provider App"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Consumer<ListService>(
              builder: (BuildContext context, ListService listService, child) {
                return Chip(
                  label: Text(listService.listCount.toString()),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FAB(),
      body: ListPage(),
    );
  }
}

class FAB extends StatelessWidget {
  Widget build(BuildContext context) {
    Icon icon;
    final listService = Provider.of<ListService>(context);
    if(listService.speed == 1) {
      icon = Icon(Icons.play_arrow);
    } else if(listService.speed == 2) {
      icon = Icon(Icons.fast_forward);
    } else {
      icon = Icon(Icons.pause);
    }

    return FloatingActionButton(
      child : icon,
      onPressed: listService.chageSpeed,
    );
  }
}

class ListPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final listService = Provider.of<ListService>(context);

    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(listService.listItem[index]),
        );
      }, 
      separatorBuilder: (BuildContext context, int index) => Divider(), 
      itemCount: listService.listCount
    );
  }
}