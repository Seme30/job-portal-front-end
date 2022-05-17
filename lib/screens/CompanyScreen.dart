import 'package:flutter/material.dart';
import 'package:job_finder/screens/loginScreen.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Company Screen'),
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
