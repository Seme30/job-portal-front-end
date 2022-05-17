import 'package:flutter/material.dart';
import 'package:job_finder/models/User.dart';
import 'package:job_finder/providers/UserProvider.dart';
import 'package:job_finder/screens/AdminScreen.dart';
import 'package:job_finder/screens/MainScreen.dart';
import 'package:job_finder/screens/CompanyScreen.dart';

class Wrapper extends StatelessWidget {
  static const routeName = 'wrapper';
  const Wrapper();

  @override
  Widget build(BuildContext context) {
    final userProvider = UserProvider();
    switch (userProvider.user.role) {
      case 'ADMIN':
        {
          return const AdminScreeen();
        }
      case 'COMPANY':
        {
          return const CompanyScreen();
        }
      default:
        {
          return MainScreen();
        }
    }
  }
}
