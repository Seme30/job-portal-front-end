class Job {
  final id;
  final title;
  final jobtype;
  final description;
  final companyname;
  final jobcategory;
  final vacancy;
  final salary;
  final posteddate;
  final deadline;
  final status;

  const Job({
    this.id,
    this.title,
    this.jobtype,
    this.description,
    this.companyname,
    this.vacancy,
    this.jobcategory,
    this.salary,
    this.posteddate,
    this.deadline,
    this.status,
  });

  factory Job.fromJson(Map<dynamic, dynamic> responseData) {
    return Job(
      id: responseData['id'],
      title: responseData['title'],
      jobtype: responseData['jobtype'],
      description: responseData['description'],
      companyname: responseData['companyname'],
      jobcategory: responseData['jobcategory'],
      salary: responseData['salary'],
      vacancy: responseData['vacancy'],
      posteddate: responseData['postedDate'],
      deadline: responseData['deadline'],
      status: responseData['status'],
    );
  }
}
