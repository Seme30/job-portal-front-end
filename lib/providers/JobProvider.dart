import 'package:flutter/material.dart';
import 'package:job_finder/models/Job.dart';

class JobProvider with ChangeNotifier {
  Job _job = new Job();
  Job get job => _job;

  List<Job> _jobs = [];

  List<Job> get jobs => _jobs;

  void setJobs(List<Job> jobs) {
    jobs = _jobs;
    notifyListeners();
  }

  void setJob(Job job) {
    job = _job;
    notifyListeners();
  }
}
