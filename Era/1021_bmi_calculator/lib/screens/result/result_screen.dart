import 'package:bmi_calculator/brains/bmi_calculator.dart';
import 'package:bmi_calculator/constants/app_style.dart';
import 'package:bmi_calculator/models/user_info.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  UserInfo userInfo = UserInfo(weight: 0, height: 0);
  BMICalculator? bmiCalc;

  @override
  Widget build(BuildContext context) {

    userInfo = ModalRoute.of(context)!.settings.arguments as UserInfo;
    bmiCalc = BMICalculator(height: userInfo.height, weight: userInfo.weight);

    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('BMI CALCULATOR'),
      centerTitle: true,
      backgroundColor: AppStyle.backgroundColor,
      elevation: 8.0,
    );
  }

  Widget buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text('Your result', style: AppStyle.titleTextStyle),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppStyle.activeCardColor,
            ),
            child: Column(
              children: [
                SizedBox(height: 40),
                Text(bmiCalc?.getResult() ?? 'Unknown', style: AppStyle.resultTextStyle),
                SizedBox(height: 10),
                Text(bmiCalc?.calculateBMI() ?? '0.0', style: AppStyle.BMITextStyle),
                Spacer(),
                Text('Normal BMI range:', style: AppStyle.bodyTextStyle.copyWith(fontSize: 20, color: Colors.white70)),
                SizedBox(height: 10),
                Text('18.5 ~ 25 kg/m2', style: AppStyle.largeButtonTextStyle),
                Spacer(),
                Text(bmiCalc?.getInterpretation() ?? 'Something wrong',
                    style: AppStyle.bodyTextStyle, textAlign: TextAlign.center),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: AppStyle.backgroundColor,
                    padding: EdgeInsets.all(14),
                    minimumSize: Size(200, 40),
                  ),
                  child: Text('SAVE RESULT'),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.pinkAccent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('RE-CALCULATE', style: AppStyle.largeButtonTextStyle),
          ),
        )
      ],
    );
  }
}
