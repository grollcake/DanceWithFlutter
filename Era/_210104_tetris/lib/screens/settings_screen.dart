import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/screens/widgets/selectedItem.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const defalutPadding = 12.0;
  List<String> menus = ['Theme', 'Block', 'Swipe', 'Code', 'About'];
  int selectedMenuIndex = 0;
  int selectedColorIndex = 0;
  int selectedShapeIndex = 0;
  List<Widget> shapes = [
    Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.indigo,
        shape: BoxShape.circle,
      ),
    ),
    Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.indigo,
        border: Border.all(
          width: 2.0,
          color: Colors.indigo.shade300,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: defalutPadding),
        decoration: BoxDecoration(color: AppStyle.bgColor.withOpacity(1.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
              child: buildTitleBar(),
            ),
            SizedBox(height: defalutPadding),
            SizedBox(
              height: 500,
              child: Row(
                children: [
                  Container(
                    width: 76,
                    height: double.infinity,
                    child: ListView.builder(
                      itemCount: menus.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            setState(() {
                              selectedMenuIndex = index;
                            });
                          },
                          title: Text(
                            menus[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: index == selectedMenuIndex ? Colors.yellowAccent : Colors.grey,
                              fontWeight: index == selectedMenuIndex ? FontWeight.w700 : FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: 1.0,
                    height: double.infinity,
                    color: Colors.grey.shade700,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 21),
                      // color: AppStyle.bgColor.withOpacity(0.95),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Color',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: 4,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 2.0,
                              crossAxisSpacing: 2.0,
                              childAspectRatio: 4 / 1,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedColorIndex = index;
                                  });
                                },
                                child: SelectedItem(
                                  selected: index == selectedColorIndex ? true : false,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      7,
                                      (index) => Container(
                                        margin: EdgeInsets.symmetric(horizontal: 1),
                                        width: 12,
                                        height: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Shape',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              shapes.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedShapeIndex = index;
                                  });
                                },
                                child: SelectedItem(
                                  selected: index == selectedShapeIndex,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: shapes[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Preview',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack buildTitleBar() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text('Settings', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        Align(
          alignment: Alignment(1, 0),
          child: ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 24,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
