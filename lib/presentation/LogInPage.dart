import 'package:flutter/material.dart';
import 'package:sendy_case_study/shared/Colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: const Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm();

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Log In',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // LinearProgressIndicator(value: _formProgress),
              SizedBox(
                height: 15,
              ),
              Text(
                'Welcome back to Sendy',
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
                'Please fill in the details below to log in.',
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
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // Password
              TextFormField(
                controller: _passwordTextController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
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
                  onPressed: () {},
                  child: Text(
                    'LOG IN',
                    style: TextStyle(
                      fontSize: 15,
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
                  'FORGOT PASSWORD',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
