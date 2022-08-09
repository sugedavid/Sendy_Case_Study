import 'package:flutter/material.dart';
import 'package:sendy_case_study/shared/Colors.dart';

import '../domain/value_objects/app_strings.dart';
import '../shared/components/Login/LoginForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          loginText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(28.0),
          child: width >= 500
              ? Center(
                  child: SizedBox(
                      width: 400,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(38.0),
                          child: LoginForm(),
                        ),
                      )))
              : LoginForm(),
        ),
      ),
    );
  }
}
