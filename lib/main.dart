import 'package:final_evaluation/db/data_base.dart';
import 'package:final_evaluation/pages/login_page.dart';
import 'package:final_evaluation/repositories/user_repository.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseHelper dbHelper = DatabaseHelper();
  final UserRepository userRepository = UserRepository(dbHelper);

  await dbHelper.conn;
  await userRepository.createTable();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "User App",
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: LoginPage(),
    );
  }
}
