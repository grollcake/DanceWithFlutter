import 'package:flutter/material.dart';
import 'package:otp_verificator/widgets/verificator.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'OTP Verificator',
      debugShowCheckedModeBanner: false,
      home: OTPVerificator(),
    ),
  );
}

class OTPVerificator extends StatefulWidget {
  const OTPVerificator({Key? key}) : super(key: key);

  @override
  _OTPVerificatorState createState() => _OTPVerificatorState();
}

class _OTPVerificatorState extends State<OTPVerificator> {
  final int length = 6;
  final double size = 36.0;

  var _verificateCode = '';
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _verificateCode = _verificateCode.padRight(length, ' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('4글자, 기본크기'),
              SizedBox(height: 10),
              Verificator(
                  length: 4,
                  onComplete: (result) {
                    print('Example1: $result');
                  }),
              SizedBox(height: 20),
              Text('5글자, 48포인트, 숫자만'),
              SizedBox(height: 10),
              Verificator(
                length: 5,
                size: 48,
                inputType: TextInputType.number,
                onComplete: (result) => print('Example2 onComplete: $result'),
                onChange: (result) => print('Example2 onChange: $result'),
              ),
              SizedBox(height: 20),
              Text('10글자, 18포인트, 이름문자'),
              SizedBox(height: 10),
              Verificator(
                length: 10,
                size: 18,
                inputType: TextInputType.name,
                onComplete: (result) => print('Example3 onComplete: $result'),
                onChange: (result) => print('Example3 onChange: $result'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
