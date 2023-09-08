import 'package:flutter/material.dart';

class ValidationForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController userNameController;
  final TextEditingController passwordController;

  ValidationForm({
    required this.formKey,
    required this.userNameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value != null && value.isNotEmpty && value.length < 5) {
                return "Your username should be more than 5 characters";
              } else if (value != null && value.isEmpty) {
                return "Please type your username";
              }
              return null;
            },
            controller: userNameController,
            decoration: InputDecoration(
                hintText: 'Add your username',
                hintStyle: TextStyle(color: Colors.blueGrey),
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            validator: (value) {
              if (value != null && value.isNotEmpty && value.length < 5) {
                return "Your password should be more than 5 characters";
              } else if (value != null && value.isEmpty) {
                return "Please type your password";
              }
              return null;
            },
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
                hintText: 'Type your password',
                hintStyle: TextStyle(color: Colors.blueGrey),
                border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }
}