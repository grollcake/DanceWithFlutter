import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:verification/screens/main/main_screen.dart';
import 'package:verification/widgets/verificator.dart';

class OTPVertificationScreen extends StatefulWidget {
  const OTPVertificationScreen({Key? key}) : super(key: key);

  @override
  _OTPVertificationScreenState createState() => _OTPVertificationScreenState();
}

class _OTPVertificationScreenState extends State<OTPVertificationScreen> {
  static const int TIMEOUT_SEC = 30;
  static const int RESEND_SEC = 10;

  String _otpCode = '';
  int _progressStatus = 0; // 0-입력중,  1-검증중,  2-통과

  int _timeoutSec = TIMEOUT_SEC;
  Timer? _timeoutTimer;

  bool _resendAvailable = true;
  int _resendSec = 0;
  Timer? _resendTimer;

  void startTimeoutTimer() {
    if (_timeoutTimer != null && _timeoutTimer!.isActive) return;
    _timeoutSec = TIMEOUT_SEC;
    _timeoutTimer?.cancel();
    _timeoutTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeoutSec <= 0) {
        timer.cancel();
        timeoutDialog();
      } else {
        setState(() {
          _timeoutSec--;
        });
      }
    });
  }

  void startResendTimer() {
    if (!_resendAvailable) return;
    _resendSec = RESEND_SEC;
    _resendAvailable = false;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendSec <= 0) {
        setState(() {
          _resendAvailable = true;
        });
        timer.cancel;
      } else {
        setState(() {
          _resendSec--;
        });
      }
    });
    _timeoutSec = TIMEOUT_SEC;
    startTimeoutTimer();
    setState(() {});
  }

  void showVerifyError() {
    Fluttertoast.showToast(
        msg: 'Code verify erro. Please retry.',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.pink.shade200,
        fontSize: 20.0,
        textColor: Colors.black87,
        toastLength: Toast.LENGTH_SHORT);
  }

  void timeoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          title: Text("Timed out"),
          content: Text("Please resend and verify again"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                startResendTimer();
              },
              child: Text('Resend'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimeoutTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade100),
                  child: Center(
                    child: Transform.rotate(
                      angle: 38,
                      child: Image.asset(
                        'assets/images/email.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Vertification',
                  style: TextStyle(color: Colors.black.withOpacity(.7), fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Please enter 6 digit code sent to\n+82 10-4204-8070',
                  style: TextStyle(color: Colors.black.withOpacity(.4), fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Visibility(
                  visible: _progressStatus != 2,
                  child: Text(
                    'Enter codes in $_timeoutSec seconds.',
                    style: TextStyle(color: Colors.black.withOpacity(.4), fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                // SizedBox(height: 30),
                // VerificationCode(
                //   length: 6,
                //   onCompleted: (result) {
                //     print('VerificationCode onCompleted: $result');
                //   },
                //   onEditing: (result) {
                //     print('VerificationCode onEditing: $result');
                //   },
                // ),
                SizedBox(height: 40),
                Verificator(
                  length: 6,
                  onCompleted: (String result) {
                    print('Got result: $result');
                    setState(() {
                      _otpCode = result;
                    });
                  },
                  onEditing: (String value) {
                    print('Now editing $value');
                    setState(() {
                      _otpCode = value;
                    });
                  },
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  // textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      "Don't resive the OTP?",
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                    ),
                    TextButton(
                      onPressed: () => startResendTimer(),
                      child: Text(_resendAvailable ? 'Resend' : 'Retry in $_resendSec seconds.',
                          style: TextStyle(color: Colors.blueAccent)),
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: _otpCode.length != 6
                      ? null
                      : () {
                          setState(() {
                            _progressStatus = 1;
                          });
                          Future.delayed(Duration(seconds: 2), () {
                            if (_otpCode == '123456') {
                              setState(() {
                                _progressStatus = 2;
                                _timeoutTimer!.cancel();
                                Future.delayed(Duration(milliseconds: 400), () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                                });
                              });
                            } else {
                              _progressStatus = 0;
                              showVerifyError();
                            }
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.black87,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: _progressStatus == 0
                      ? Text('Verify', style: TextStyle(fontSize: 18))
                      : _progressStatus == 1
                          ? SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(),
                            )
                          : Icon(Icons.check_circle, color: Colors.white, size: 24),
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
