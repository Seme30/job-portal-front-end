import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:job_finder/models/Job.dart';
import 'package:job_finder/providers/JobProvider.dart';
import 'package:job_finder/services/AppUrl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class JobService {
  static Future<Map<dynamic, dynamic>> getAllJobs() async {
    Map<dynamic, dynamic> result;
    http.Response response = await http.get(Uri.parse(AppUrl.jobs),
        headers: {'Content-Type': 'application/json'}).catchError(onError);
    print(response.body);
    print("From response body");
    List<Job> jobs = [];
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseData[0]);
      print("response data from jobservice");
      // now we will create a user model
      for (var element in responseData) {
        jobs.add(Job.fromJson(element));
      }

      // jobs = responseData.map((e) => Job.fromJson(e)).toList();
      print(jobs[0].title);
      print("from jobs list");
      // JobProvider jobprov = new JobProvider();
      // now we will create shared preferences and save data
      // jobprov.setJobs(jobs);

      // Provider.of<JobProvider>(context, listen: false).setJobs(jobs);
      print("job provider is set");
      result = {
        'status': true,
        'message': 'Job Successfully retrieved',
        'data': jobs
      };
    } else {
      result = {
        'status': false,
        'message': 'Job retrieval failed',
        'data': responseData
      };
    }
    print(jobs[0].title);
    print("jobs[0].title from  jobslist is printed");
    return result;
  }

  static onError(error) {
    print('the error is ${error.detail}');
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
