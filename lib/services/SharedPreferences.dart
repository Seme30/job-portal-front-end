import 'package:shared_preferences/shared_preferences.dart';
import 'package:job_finder/models/User.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', user.id as int);
    prefs.setString('username', user.username);
    prefs.setString('role', user.role);
    prefs.setString('password', user.password);
    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? id = prefs.getInt("id");
    String? username = prefs.getString("username");
    String? password = prefs.getString("password");
    String? role = prefs.getString("role");

    return User(
      id: id,
      username: username,
      role: role,
      password: password,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('username');
    prefs.remove('password');
    prefs.remove('role');
  }
}
