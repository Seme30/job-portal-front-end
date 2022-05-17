import 'package:flutter/material.dart';
import 'package:job_finder/screens/loginScreen.dart';

class AdminScreeen extends StatelessWidget {
  const AdminScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Admin Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Log out'),
        onPressed: () {
          Navigator.pushReplacementNamed(context, LoginScreen.loginRoute);
        },
      ),
    );
  }
}
