import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:job_finder/models/WebJob.dart';
import 'package:job_finder/widgets/MainDrawer.dart';
// import 'package:web_scraper/web_scraper.dart';

class ShowScrappedScreen extends StatefulWidget {
  const ShowScrappedScreen({Key? key}) : super(key: key);
  static const String routeName = "ShowScrappedScreen";
  @override
  State<ShowScrappedScreen> createState() => _ShowScrappedScreenState();
}

class _ShowScrappedScreenState extends State<ShowScrappedScreen> {
  bool isLoading = true;
  List<WebJob> JobList = [];
  Future<List<WebJob>> _getData = Future(() {
    return [];
  });

  void initState() {
    _getData = _getWebsiteData();
    super.initState();
  }

  Future<List<WebJob>> _getWebsiteData() async {
    final url = Uri.parse('https://etcareers.com/jobs/?&p=4');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final title = html
        .querySelectorAll(
            'div.media-body > div.media-heading.listing-item__title > a')
        .map((element) => element.innerHtml.trim())
        .toList();
    print(title[0]);

    final company = html
        .querySelectorAll(
            'span.listing-item__info--item.listing-item__info--item-company')
        .map((element) => element.innerHtml.trim())
        .toList();
    print(company[0]);
    final place = html
        .querySelectorAll(
            'span.listing-item__info--item.listing-item__info--item-location')
        .map((element) => element.innerHtml.trim())
        .toList();
    print(place);
    final level = html
        .querySelectorAll('div.media-body > div.media-right.text-right > span')
        .map((element) => element.innerHtml.trim())
        .toList();
    print(level[0]);
    final date = html
        .querySelectorAll('div.media-body > div.media-right.text-right > div')
        .map((element) => element.innerHtml.trim())
        .toList();
    print(date[0]);
    final description = html
        .querySelectorAll('div.media-body > div.listing-item__desc')
        .map((element) => element.innerHtml.trim())
        .toList();
    print(description[0]);
    JobList = List.generate(
      title.length,
      (index) => WebJob(title[index], company[index], place[index],
          level[index], date[index], description[index]),
    );
    return JobList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs from web'),
      ),
      drawer: MainDrawer(),
      body: FutureBuilder<List<WebJob>>(
        future: _getData,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              final Jobs = snapshot.data;
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.builder(
                    itemCount: Jobs!.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                          child: Padding(
                        padding: EdgeInsets.all(20),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(Jobs[index].date),
                          ),
                          title: Text(Jobs[index].title),
                          subtitle: Text(Jobs[index].description),
                          trailing: Text(Jobs[index].place),
                        ),
                      ));
                    },
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
