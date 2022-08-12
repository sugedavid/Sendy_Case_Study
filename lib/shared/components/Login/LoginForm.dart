import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../domain/value_objects/app_strings.dart';
import '../../../presentation/HomePage.dart';
import '../../Colors.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool showLoader = false;
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int _start = 2;

    void startTimer() {
      showLoader = true;
      const oneSec = const Duration(seconds: 1);

      _timer = new Timer.periodic(
        oneSec,
        (Timer timer) {
          if (_start == 0) {
            showLoader = false;
            setState(() {
              timer.cancel();
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {
            setState(() {
              _start--;
            });
          }
        },
      );
    }

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              loginTitle,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              loginBody,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // Email
            TextFormField(
              controller: _emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: emailText,
                labelStyle: TextStyle(
                  fontSize: 15,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is incorrect';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),

            // Password
            TextFormField(
              controller: _passwordTextController,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                labelText: passwordText,
                labelStyle: TextStyle(
                  fontSize: 15,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password must be at least six characters';
                }
                return null;
              },
              obscureText: true,
            ),
            SizedBox(
              height: 40,
            ),

            // Log In
            Container(
              width: double.infinity,
              height: 45,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: AppColors.primaryColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
                onPressed: () {
                  // validate form
                  if (_formKey.currentState!.validate()) {
                    startTimer();
                  }
                },
                child: (showLoader == true)
                    ? Center(
                        child: LoadingAnimationWidget.beat(
                          color: Colors.white,
                          size: 24,
                        ),
                      )
                    : Text(
                        loginText.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            // Forgot Password
            Center(
              child: Text(
                forgotPasswordText,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
