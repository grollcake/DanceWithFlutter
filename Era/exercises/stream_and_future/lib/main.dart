import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream and future',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stream and future'),
        ),
        body: StreamAndFuture(),
      ),
    );
  }
}

class StreamAndFuture extends StatefulWidget {

  @override
  _StreamAndFutureState createState() => _StreamAndFutureState();
}

class _StreamAndFutureState extends State<StreamAndFuture> {
  List<String> _results = [];

  Stream<List<String>> _streamGenerator() async* {
    print('_streamGenerator started');

    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(milliseconds: 100));
      String value = (_results.length + 1).toString();
      // print('generated: $value');
      if (_results.length > 0) {
        _results[_results.length-1] += ' already yielded';
      }
      _results.add(value);
      yield _results;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
        stream: _streamGenerator(),
        builder: (context, snapshot) {
          print('connectionState: ${snapshot.connectionState} count: ${snapshot.data?.length ?? 0}');
          return ListView.separated(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data[index]),
                  onTap: () {
                    if (index == snapshot.data.length -1 ) {
                      print('Last item tapped');
                      _streamGenerator();
                      setState(() {});
                    }
                  }
                );
              },
              separatorBuilder: (context, index) => Divider());
        });
  }
}
