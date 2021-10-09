import 'package:flutter/material.dart';

void main() => runApp(const PasswordValidation());

class PasswordValidation extends StatelessWidget {
  const PasswordValidation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Let`s Play with Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lime),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> _colors = [
    Colors.orange[300]!,
    Colors.yellow[300]!,
    Colors.green[300]!,
    Colors.indigo[300]!
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     title: const Text(
        //       'Let`s Play with Flutter',
        //       style: TextStyle(fontWeight: FontWeight.bold),
        //     ),
        //     centerTitle: true,
        //     elevation: 0),
        body: Container(
      color: Colors.grey,
      child: GridView.builder(
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: MediaQuery.of(context).size.height / 2),
          itemBuilder: (context, index) {
            return Container(
              color: _colors[index],
              child: Row(
                children: [
                  Expanded(child: Container(), flex: 2,),
                  Expanded(
                    flex: 6,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text('버튼 #' + (index+1).toString()),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  Expanded(child: Container(), flex: 2,),
                ],
              ),
            );
          }),
    ));
  }
}

class MyBox extends StatelessWidget {
  const MyBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
