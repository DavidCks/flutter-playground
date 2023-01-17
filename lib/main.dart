import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../data_structures/_dict.dart';
import '../../styles/_page_styles.dart';
import '../../styles/_text_styles.dart';
import '../../errors/_json_parse.dart';

void main() {
  runApp(const MyApp());
}

// App Instantiation
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String title = 'CJK App Test';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(title),
          ),
          body: const DictListPage(title: 'CJK Dict List')),
    );
  }
}

class DictListPage extends StatefulWidget {
  const DictListPage({super.key, required this.title});

  final String title;

  @override
  State<DictListPage> createState() => _DictListPageState();
}

// loads the json file and updates its own state on load
class _DictListPageState extends State<DictListPage> {
  List<Dict> _dictsData = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // define loader for data stored in catalogue.json and sets _dictsData data accordingly
  _loadData() async {
    String jsonString = await rootBundle.loadString('catalogue.json');
    try {
      List<dynamic> jsonData = jsonDecode(jsonString);
      setState(() {
        _dictsData = jsonData
            .asMap()
            .map((i, item) {
              item['author'] ?? (throwMissingKeyError(context, 'author', i));
              item['description'] ??
                  (throwMissingKeyError(context, 'description', i));
              item['image'] ?? (throwMissingKeyError(context, 'image', i));
              item['isbn'] ?? (throwMissingKeyError(context, 'isbn', i));
              item['name'] ?? (throwMissingKeyError(context, 'name', i));
              item['publication'] ??
                  (throwMissingKeyError(context, 'publication', i));

              return MapEntry(
                  i,
                  Dict(
                      author: item['author'].toString(),
                      description: item['description'].toString(),
                      imageUrl: item['image'].toString(),
                      isbn: item['isbn'].toString(),
                      name: item['name'].toString(),
                      publication: item['publication'].toString()));
            })
            .values
            .toList();
      });
    } catch (e) {
      switch (e.runtimeType) {
        case FormatException:
          throwJsonParseError(context);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_dictsData.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return ListView.builder(
        itemCount: _dictsData.length,
        itemBuilder: (context, index) {
          return _DictListPageView(dict: _dictsData[index]);
        });
  }
}

// displays an image of a dict and adds an ontap event to open a details page
class _DictListPageView extends StatelessWidget {
  const _DictListPageView({super.key, required this.dict});

  final Dict dict;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text(dict.name),
                ),
                body: _DictDetailsPageView(
                  dict: dict,
                ),
              ),
            ),
          );
        },
        child: Container(
          padding: PageStyles.listPagePadding,
          child: Hero(
            tag: dict.imageUrl,
            child: Image.network(
              dict.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}

// displays the details page view
class _DictDetailsPageView extends StatelessWidget {
  const _DictDetailsPageView({super.key, required this.dict});

  final Dict dict;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PageStyles.detailsPagePadding,
      child: ListView(
        children: [
          Hero(
              tag: dict.imageUrl,
              child: Image.network(dict.imageUrl, fit: BoxFit.cover)),
          Text(dict.name, style: TextStyles.titleTextStyle),
          Text(dict.author, style: TextStyles.authorTextStyle),
          const Divider(),
          Text(dict.description, style: TextStyles.descriptionTextStyle),
          const Divider(),
          Text('Published: ${dict.publication}',
              style: TextStyles.publicationTextStyle),
          Text('ISBN: ${dict.isbn}', style: TextStyles.isbnTextStyle),
        ],
      ),
    );
  }
}
