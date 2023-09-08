import 'package:flutter/material.dart';
import 'package:final_evaluation/model/user.dart';
import 'package:final_evaluation/repositories/user_repository.dart';
import 'package:final_evaluation/db/data_base.dart';

class UserInformationPage extends StatefulWidget {
  final UserRepository _userRepository = UserRepository(DatabaseHelper());

  final int userId;
  late String username;
  late String password;

  UserInformationPage({Key? key, required this.username, required this.password, required this.userId}) : super(key: key);

  @override
  _UserInformationPageState createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<UserInformationPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
    _passwordController = TextEditingController(text: widget.password);
  }

  void _savePressed() async {

    final newUser = User(userId: widget.userId, username: _usernameController.text, password: _passwordController.text);

    try {
      final user = await widget._userRepository.findUserByUserId(widget.userId);

      if (user != null) {
        if(newUser == user) {
          print("Aucune modification apportée");
        } else {
          widget._userRepository.updateUser(newUser, user.userId);
        }
      } else {
        widget._userRepository.insertUser(newUser);
        print('Utilisateur ajouté');
      }
    } catch (e) {
      print('Une erreur s\'est produite lors de la recherche de l\'utilisateur : $e');
    }
  }

  void _updatePressed() {
    String newUsername = widget.username;
    String newPassword = widget.password;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modifier les informations'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  newUsername = value; // Mettre à jour la variable locale
                },
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Nouveau nom d\'utilisateur'),
              ),
              TextField(
                onChanged: (value) {
                  newPassword = value; // Mettre à jour la variable locale
                },
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Nouveau mot de passe'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue sans enregistrer
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                // Enregistrer les modifications depuis la boîte de dialogue en utilisant les variables locales
                setState(() {
                  widget.username = newUsername;
                  widget.password = newPassword;
                });
                Navigator.of(context).pop(); // Fermer la boîte de dialogue après l'enregistrement
              },
              child: Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bonjour ${widget.username}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ID de l\'utilisateur',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              '${widget.userId}',
              style: TextStyle(fontSize: 12.0, color: Colors.deepOrange),
            ),
            SizedBox(height: 20.0),
            Text(
              'Nom d\'utilisateur',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              '${widget.username}',
              style: TextStyle(fontSize: 12.0, color: Colors.deepOrange),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _savePressed,
                  child: Text('Enregistrer'),
                ),
                ElevatedButton(
                  onPressed: _updatePressed,
                  child: Text('Modifier'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
