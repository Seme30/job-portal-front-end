import 'package:flutter/material.dart';
import 'package:job_finder/models/User.dart';
import 'package:job_finder/providers/AuthProvider.dart';
import 'package:job_finder/providers/UserProvider.dart';

import 'package:job_finder/widgets/AuthForm.dart';
import 'package:job_finder/widgets/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const loginRoute = "loginRoute";

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    void _registerUser(String username, String password, String role) async {
      await auth.register(username, password, role).then((response) {
        if (response['status']) {
          User user = response['data'];
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          Navigator.pushReplacementNamed(context, LoginScreen.loginRoute);
        } else {
          Flushbar(
            title: "Registration Failed",
            message: response.toString(),
            duration: Duration(seconds: 10),
          ).show(context);
        }
      });
    }

    void _submitFun(String username, String password, String role) async {
      await auth.login(username, password).then((response) {
        print(response['status']);
        if (response['status']) {
          print(response['status']);
          User user = response['user'];
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          Navigator.pushReplacementNamed(context, Wrapper.routeName);
        } else {
          Flushbar(
            title: "Failed Login",
            message: response['message']['message'].toString(),
            duration: Duration(seconds: 3),
          ).show(context);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: AuthForm(_submitFun, _registerUser),
    );
  }
}
