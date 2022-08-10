import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    final _emailTextController = TextEditingController();
    final _passwordTextController = TextEditingController();

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  }
                },
                child: Text(
                  loginText.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            // Center(
            //   child: LoadingAnimationWidget.beat(
            //     color: AppColors.primaryColor,
            //     size: 24,
            //   ),
            // ),
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
