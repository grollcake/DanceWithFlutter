import 'package:counter_provider/controllers/count_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter provider example'),
      ),
      body: MainWidget(),
      floatingActionButton: FabWidget(),
    );
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // int count = Provider.of<CountController>(context).count;
    print('MainWidget > build');

    return Center(
      child: Text(
        Provider.of<CountController>(context).count.toString(),
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class FabWidget extends StatelessWidget {
  const FabWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountController _countController = Provider.of<CountController>(context);

    print('FabWidget > build');
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              _countController.add();
            },
            icon: Icon(Icons.add)),
        Builder(
          builder: (BuildContext context) {
            CountController _countController2 = Provider.of<CountController>(context);
            return IconButton(
                onPressed: () {
                  _countController2.remove();
                },
                icon: Icon(Icons.remove));
          },
        ),
      ],
    );
  }
}
