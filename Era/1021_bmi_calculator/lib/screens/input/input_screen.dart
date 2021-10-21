import 'package:bmi_calculator/constants/app_style.dart';
import 'package:bmi_calculator/models/gender.dart';
import 'package:bmi_calculator/screens/input/widgets/reusable_card.dart';
import 'package:bmi_calculator/screens/input/widgets/round_button.dart';
import 'package:bmi_calculator/screens/result/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  Gender gender = Gender.none;
  int height = 170;
  int weight = 60;
  int age = 26;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('BMI CALCULATOR'),
      centerTitle: true,
      backgroundColor: Color(0xFF0A0E21),
      elevation: 8.0,
    );
  }

  Widget buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      gender = gender == Gender.male ? Gender.none : Gender.male;
                    });
                  },
                  child: ReusableCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.mars, color: Colors.white, size: 72),
                        SizedBox(height: 8),
                        Text('MALE', style: AppStyle.labelTextStyle),
                      ],
                    ),
                    isActive: gender == Gender.male,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      gender = gender == Gender.female ? Gender.none : Gender.female;
                    });
                  },
                  child: ReusableCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.rotate(
                          angle: 0.8,
                          child: Icon(FontAwesomeIcons.venus, color: Colors.white, size: 72),
                        ),
                        SizedBox(height: 8),
                        Text('FEMALE', style: AppStyle.labelTextStyle),
                      ],
                    ),
                    isActive: gender == Gender.female,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ReusableCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('HEIGHT', style: AppStyle.labelTextStyle),
                Text.rich(
                  TextSpan(
                    style: AppStyle.numberTextStyle,
                    text: height.toString(),
                    children: [
                      TextSpan(text: ' cm', style: AppStyle.labelTextStyle.copyWith(fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Colors.white,
                    trackHeight: 1.6,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 14.0,
                    ),
                    thumbColor: Colors.pinkAccent,
                    overlayColor: Colors.pinkAccent.withOpacity(.32),
                  ),
                  child: Slider(
                    min: 120,
                    max: 220,
                    value: height.toDouble(),
                    onChanged: (double value) {
                      setState(() {
                        height = value.toInt();
                      });
                    },
                    // activeColor: Colors.pinkAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ReusableCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('WEIGHT', style: AppStyle.labelTextStyle),
                      Text(weight.toString(), style: AppStyle.numberTextStyle),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RoundButton(onPressed: (){
                            setState(() {
                              weight--;
                            });
                          }, icon: FontAwesomeIcons.minus),
                          RoundButton(onPressed: (){
                            setState(() {
                              weight++;
                            });
                          }, icon: FontAwesomeIcons.plus),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ReusableCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('AGE', style: AppStyle.labelTextStyle),
                      Text(age.toString(), style: AppStyle.numberTextStyle),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RoundButton(onPressed: (){
                            setState(() {
                              age--;
                            });
                          }, icon: FontAwesomeIcons.minus),
                          RoundButton(onPressed: (){
                            setState(() {
                              age++;
                            });
                          }, icon: FontAwesomeIcons.plus),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        MaterialButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen()));
          },
          color: Colors.pinkAccent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('CALCULATE', style: AppStyle.largeButtonTextStyle),
          ),
        ),
      ],
    );
  }
}
