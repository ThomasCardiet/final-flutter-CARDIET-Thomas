import 'package:final_evaluation/db/data_base.dart';
import 'package:final_evaluation/model/user.dart';
import 'package:mysql1/src/results/row.dart';
import 'package:mysql1/src/single_connection.dart';

class UserRepository {

  final DatabaseHelper _dbHelper;
  UserRepository(this._dbHelper);

  Future<void> createTable() async {
    final conn = await _dbHelper.conn;
    try {
      await conn.query('''
        CREATE TABLE IF NOT EXISTS user (
          id INT AUTO_INCREMENT PRIMARY KEY,
          userId BIGINT NOT NULL,
          username VARCHAR(255) NOT NULL,
          password VARCHAR(255) NOT NULL
        )
      ''');
      print('Table "user" created successfully.');
    } catch (e) {
      print('Error creating table: $e');
    }
  }

  Future<dynamic> insertUser(User user) async {
    final conn = await _dbHelper.conn;
    final result = await conn.query(
      'INSERT INTO user (userId, username, password) VALUES (?, ?, ?)',
      [user.userId, user.username, user.password],
    );
    print("$user enregistré");
    return result;

  }

  Future<User?> findUserByUserId(int userId) async {
    final conn = await _dbHelper.conn;
    final Results results = await conn.query(
      'SELECT * FROM user WHERE userId = ?',
      [userId],
    );

    if (results.isNotEmpty) {
      final ResultRow userData = results.first;
      return User.fromMap(userData.fields);
    } else {
      return null;
    }
  }

  Future<void> updateUser(User newData, userId) async {
    final conn = await _dbHelper.conn;
    await conn.query(
      'UPDATE user SET username = ?, password = ? WHERE userId = ?',
      [newData.username, newData.password, userId],
    );
    print("UserId: $userId mis à jour");
  }
}