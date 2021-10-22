import 'package:bmi_calculator/constants/app_style.dart';
import 'package:bmi_calculator/models/gender.dart';
import 'package:bmi_calculator/models/like_status.dart';
import 'package:bmi_calculator/models/user_info.dart';
import 'package:bmi_calculator/screens/input/widgets/reusable_card.dart';
import 'package:bmi_calculator/screens/input/widgets/round_button.dart';
import 'package:bmi_calculator/widgets/custom_appbar.dart';
import 'package:bmi_calculator/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final GlobalKey<ScaffoldState> appBarKey = GlobalKey();

  Gender gender = Gender.none;
  int height = 170;
  int weight = 60;
  int age = 26;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: appBarKey,
      appBar: buildCustomAppbar('BMI CALCULATOR', appBarKey),
      drawer: buildCustomDrawer(LikeStatus.likeIt, () {
        if (LikeStatus.likeIt) {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: '한번 좋아한다 했으면 물리기 없기!',
              backgroundColor: Colors.pinkAccent.shade100,
              icon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(FontAwesomeIcons.exclamationCircle, size: 24),
              ),
            ),
          );
        } else {
          setState(() {
            LikeStatus.likeIt = !LikeStatus.likeIt;
          });
        }
      }),
      body: buildBody(),
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
                        Icon(FontAwesomeIcons.mars,
                            color: gender == Gender.male ? Colors.white : Color(0xFF8D8E98), size: 72),
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
                          child: Icon(FontAwesomeIcons.venus,
                              color: gender == Gender.female ? Colors.white : Color(0xFF8D8E98), size: 72),
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
                          RoundButton(
                              onPressed: () {
                                setState(() {
                                  weight--;
                                });
                              },
                              icon: FontAwesomeIcons.minus),
                          RoundButton(
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                              icon: FontAwesomeIcons.plus),
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
                          RoundButton(
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                              icon: FontAwesomeIcons.minus),
                          RoundButton(
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                              icon: FontAwesomeIcons.plus),
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
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen()));
            if (gender == Gender.none) {
              showTopSnackBar(
                context,
                CustomSnackBar.error(
                  message: 'Please select your gender',
                  backgroundColor: Colors.pinkAccent.shade100,
                  icon: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(FontAwesomeIcons.exclamationCircle, size: 24),
                  ),
                ),
              );
            } else {
              Navigator.pushNamed(context, '/result', arguments: UserInfo(height: height, weight: weight));
            }
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
