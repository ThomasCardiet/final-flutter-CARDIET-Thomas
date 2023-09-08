import 'dart:convert';

class User {
  int? userId;
  String? username;
  String? password;

  User({
    this.userId,
    this.username,
    this.password,
  });

  User copyWith({
    int? userId,
    String? username,
    String? password,
  }) {
    return User(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (userId != null) {
      result.addAll({'userId': userId});
    }
    if (username != null) {
      result.addAll({'username': username});
    }
    if (password != null) {
      result.addAll({'password': password});
    }

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId']?.toInt(),
      username: map['username'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $userId, name: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.userId == userId && other.username == username && other.password == password;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ username.hashCode ^ password.hashCode;
  }
}
