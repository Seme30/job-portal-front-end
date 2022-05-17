class User {
  final id;
  final username;
  final role;
  final password;

  const User({
    this.id,
    this.username,
    this.role,
    this.password,
  });

  factory User.fromJson(Map<dynamic, dynamic> responseData) {
    return User(
      id: responseData['id'],
      username: responseData['username'],
      password: responseData['password'],
      role: responseData['role'],
    );
  }
}
