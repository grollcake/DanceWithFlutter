import 'package:flutter/material.dart';
import 'package:practice_provider_pattern/service/list_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ListService(),
      child: MaterialApp(
        title : 'Provider Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home : HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title : Text('Provider Demo'),
    actions: [
        Consumer<ListService>(
        builder: (BuildContext, listService, index){
            return Chip(
              label: Text(listService.listCount.toString()),
            );
        },
    )
      ]
    ),
      body : ListPage2(),
      floatingActionButton: FAB(),
    );
  }
}

class ListPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context){

          final listService = Provider.of<ListService>(context);

          return ListView.separated(
              itemCount : listService.listCount,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder : (BuildContext context, int index){
                return ListTile(
                  title : Text(listService.listItems[index]),
                );
              }
          );
        }
    );
  }
}
class FAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Icon icon;
    final listService = Provider.of<ListService>(context);

    if(listService.speed == 1){
      icon = Icon(Icons.play_arrow);
    }else if(listService.speed == 2){
      icon = Icon(Icons.fast_forward);
    }else if(listService.speed == 0){
      icon = Icon(Icons.pause);
    }
    return FloatingActionButton(
      onPressed: (){
        listService.changeSpeed();
      },
      child : icon,
    );
  }
}

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context){

          final listService = Provider.of<ListService>(context);

          return ListView.separated(
              itemCount : listService.listCount,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder : (BuildContext context, int index){
                return ListTile(
                  title : Text(listService.listItems[index]),
                );
              }
          );
        }
    );
  }
}