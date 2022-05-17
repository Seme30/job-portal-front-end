import 'package:flutter/material.dart';
import 'package:job_finder/models/User.dart';
import 'package:job_finder/providers/JobProvider.dart';
import 'package:job_finder/screens/ShowScrappedScreen.dart';
import 'package:job_finder/services/SharedPreferences.dart';
import 'package:job_finder/providers/UserProvider.dart';
import 'package:job_finder/providers/AuthProvider.dart';
import 'package:job_finder/screens/MainScreen.dart';
import 'package:job_finder/widgets/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:job_finder/screens/loginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreferences().getUser();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
        ChangeNotifierProvider.value(
          value: JobProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Ethio Job Finder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  // if (snapshot.hasError)
                  //   return Text('Error: ${snapshot.error}');
                  // else if (snapshot.data?.token == null)
                  //   return LoginScreen();
                  // else
                  // UserPreferences().removeUser();
                  return LoginScreen();
              }
            }),
        routes: {
          LoginScreen.loginRoute: (context) => const LoginScreen(),
          MainScreen.routeName: (context) => MainScreen(),
          Wrapper.routeName: (context) => const Wrapper(),
          ShowScrappedScreen.routeName: (context) => const ShowScrappedScreen(),
        },
      ),
    );
  }
}
