import 'package:final_evaluation/constants.dart';
import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  MySqlConnection? _conn;

  Future<MySqlConnection> get conn async {
    if (_conn == null) {
      try {
        final settings = ConnectionSettings(
          host: dbHost,
          port: dbPort,
          user: dbUser,
          db: dbName,
          password: dbPassword,
        );
        _conn = await MySqlConnection.connect(settings);
      } catch (e) {
        print("Erreur lors de la connexion à la base de données: $e");
      }
    }
    return _conn!;
  }
}