import 'package:flutter/material.dart';
import 'package:job_finder/models/Job.dart';

class JobListBuilder extends StatefulWidget {
  final List<Job> jobs;

  const JobListBuilder(this.jobs);

  @override
  State<JobListBuilder> createState() => _JobListBuilderState();
}

class _JobListBuilderState extends State<JobListBuilder> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.builder(
        itemBuilder: (context, index) {
          print(widget.jobs[0].title + " from job list builder");
          return ListTile(
            leading: CircleAvatar(
              child: Text(widget.jobs[index].companyname),
            ),
            title: Text(widget.jobs[index].title),
            subtitle: Text(widget.jobs[index].description),
            trailing: CircleAvatar(
              child: Text(widget.jobs[index].deadline),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        },
        itemCount: widget.jobs.length,
      ),
    );
  }
}
