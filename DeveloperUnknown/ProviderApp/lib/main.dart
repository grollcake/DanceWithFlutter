import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ProviderApp/service/list_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListService> (
      create: (BuildContext context) => ListService(),
      child: MaterialApp(
        title: "Provider app",
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
        title: Text('provider'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Consumer<ListService> (
              builder: (BuildContext context, ListService listService, child) {
                return Chip(
                  label: Text(listService.listCount.toString()),
                );
              },
            )
          )
        ],
      ),
      body: ListPage(),
      floatingActionButton: FAB(),
    );
  }
}

class FAB extends StatelessWidget {
  Widget build(BuildContext context) {
    Icon icon;
    final listService = Provider.of<ListService>(context);
    if (listService.speed == 1) {
      icon = Icon(Icons.play_arrow);
    } else if (listService.speed == 2) {
      icon = Icon(Icons.fast_forward);
    } else if (listService.speed == 0) {
      icon = Icon(Icons.pause);
    }

    return FloatingActionButton(
      onPressed: () {
        listService.changeSpeed();
      },
      child: icon,
    );
  }
}

class ListPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        final listService = Provider.of<ListService>(context);
        return ListView.separated(
          itemCount: listService.listCount,
          separatorBuilder: (BuildContext context, int index) => Divider(), 
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(listService.listItems[index]),
            );
          });
      },
    );
  }
}