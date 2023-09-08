import 'dart:math';

import 'package:final_evaluation/pages/user_information_page.dart';
import 'package:final_evaluation/utils/user_functions.dart';
import 'package:flutter/material.dart';
import 'package:final_evaluation/widgets/validation_form.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  void loginUser(context) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserInformationPage(
            userId: generateRandomID(),
            username: userNameController.text,
            password: passwordController.text,
          ),
        ),
      );
    }
  }

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/pc.jpeg', width: 200),
              ValidationForm(
                formKey: _formKey,
                userNameController: userNameController,
                passwordController: passwordController,
              ),

          Padding(
            padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                onPressed: () => {
                  loginUser(context)
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                ),
              ),
            )
              // Vos autres widgets ici
            ],
          ),
        ),
      ),
    );
  }
}