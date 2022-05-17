import 'package:flutter/material.dart';
import 'package:job_finder/models/User.dart';
import 'package:job_finder/providers/UserProvider.dart';
import 'package:job_finder/screens/MainScreen.dart';
import 'package:job_finder/screens/ShowScrappedScreen.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  Widget buildListTile(String title, IconData icon, Function selectHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Raleway',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        selectHandler();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.secondary,
            child: Text(
              'Hello ${user.username}',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          buildListTile('Jobs', Icons.work, () {
            Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
          }),
          Divider(),
          buildListTile('Jobs from Websites', Icons.web, () {
            Navigator.of(context)
                .pushReplacementNamed(ShowScrappedScreen.routeName);
          }),
        ],
      ),
    );
  }
}
