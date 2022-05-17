import 'package:flutter/material.dart';
import 'package:job_finder/models/Job.dart';
import 'package:job_finder/models/User.dart';
import 'package:job_finder/providers/JobProvider.dart';
import 'package:job_finder/screens/loginScreen.dart';
import 'package:job_finder/services/JobService.dart';
import 'package:job_finder/widgets/JobListBuilder.dart';
import 'package:job_finder/widgets/MainDrawer.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

import '../providers/UserProvider.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = "MainScreen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<List<Job>> _getData = Future<List<Job>>(
    () {
      return [];
    },
  );
  @override
  void initState() {
    _getData = getJobs();
    super.initState();
  }

  Future<List<Job>> getJobs() async {
    List<Job> jobs = [];
    await JobService.getAllJobs().then((response) {
      print("From _getJobs in MainScreen");
      if (response['status']) {
        print("From _getJobs inside status true");
        print(response['status']);
        jobs = response['data'];
        Provider.of<JobProvider>(context, listen: false).setJobs(jobs);
        // Navigator.pushReplacementNamed(context, LoginScreen.loginRoute);
      } else {
        print(response['status']);
        Flushbar(
          title: "Job Retrieval Failed",
          message: response.toString(),
          duration: Duration(seconds: 10),
        );
      }
    });
    print(jobs[0].title);
    return jobs;
  }

  @override
  Widget build(BuildContext context) {
    // final user = UserProvider();
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, LoginScreen.loginRoute);
            },
            icon: Icon(Icons.logout)),
      ]),
      drawer: MainDrawer(),
      body: FutureBuilder<List<Job>>(
          future: _getData,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                final jobs = snapshot.data;
                Widget buildListView(BuildContext context) {
                  print("inside build list view");
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(jobs?[index].companyname as String),
                        ),
                        title: Text(jobs?[index].title as String),
                        subtitle: Text(jobs?[index].description as String),
                        trailing: CircleAvatar(
                          child: Text(jobs?[index].deadline as String),
                          backgroundColor: Theme.of(context).errorColor,
                        ),
                      );
                    },
                    itemCount: snapshot.data?.length,
                  );
                }
                // Provider.of<JobProvider>(context, listen: false).setJobs(jobs);
                return buildListView(context);
              default:
                return Text("Hello");
              // JobListBuilder(jobs);
              //// : Text('jobs is empty');
            }
          }),
    );
  }
}
//  ListView(
//                   children: jobs.map((e) {
//                     return

//                   }).toList(),
//                 );