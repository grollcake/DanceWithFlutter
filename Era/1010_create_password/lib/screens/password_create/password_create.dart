import 'package:create_password/screens/password_create/widgets/passwd_valid_checker.dart';
import 'package:flutter/material.dart';

class PasswordCreate extends StatefulWidget {
  const PasswordCreate({Key? key}) : super(key: key);

  @override
  _PasswordCreateState createState() => _PasswordCreateState();
}

class _PasswordCreateState extends State<PasswordCreate> {
  bool _isPasswordHas8Length = false;
  bool _isPasswordHasOneNumber = false;
  bool _passwordVisibility = false;

  void onPasswordChange(String password) {
    setState(() {
      _isPasswordHas8Length = password.length >= 8;

      var regex = RegExp(r'[0-9]+');
      _isPasswordHasOneNumber = regex.hasMatch(password);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Your Account', style: TextStyle(color: Colors.black87)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Set a password', style: TextStyle(fontSize: 24, color: Colors.black87, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('Please create a secure password including following criteria below',
                style: TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 30),
            TextField(
              onChanged: onPasswordChange,
              obscureText: !_passwordVisibility,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordVisibility = !_passwordVisibility;
                    });
                  },
                  icon: _passwordVisibility
                      ? const Icon(Icons.visibility, color: Colors.black87)
                      : const Icon(Icons.visibility_off, color: Colors.grey),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            PasswordValidChecker(isValid: _isPasswordHas8Length, message: 'Contains at least 8 characters'),
            const SizedBox(height: 10),
            PasswordValidChecker(isValid: _isPasswordHasOneNumber, message: 'Contains at least 1 number'),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: (_isPasswordHas8Length && _isPasswordHasOneNumber) ? (){} : null,
              style: ElevatedButton.styleFrom(
                  primary: Colors.black87,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child: const Text(
                'Create Account',
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
