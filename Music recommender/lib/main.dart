import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Song Recommender',
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark, // set dark mode for entire app
        scaffoldBackgroundColor:
            Colors.black, // set the background color to black
      ),
      home: MyHomePage(title: 'Song Recommender'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Load CSV data from asset folder

  Future<List<dynamic>> loadAsset() async {
    final myData = await rootBundle.loadString('assets/mini_data.csv');
    List<dynamic> rowsAsListOfValues =
        const CsvToListConverter().convert(myData);
    return rowsAsListOfValues;
  }

  List<dynamic>? csvData;

  @override
  void initState() {
    super.initState();
    loadAsset().then((d) {
      setState(() {
        csvData = d;
      });
    });
  }

  // Generate random song recommendations

  List<List<dynamic>>? recommendedSongs;

  void generateRecommendations() {
    if (csvData != null) {
      var random = Random();
      List<List<dynamic>> temp = [];
      for (var i = 0; i < 10; i++) {
        int randomIndex = random.nextInt(csvData!.length - 1) + 1;
        var songTitle = csvData![randomIndex][1];
        var songYear = csvData![randomIndex][3];
        temp.add([songTitle, songYear]);
      }
      setState(() {
        recommendedSongs = temp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Component #1
          Expanded(
              child: ListView.builder(
                  itemCount: csvData != null ? csvData!.length - 2 : 0,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text('${csvData![index + 2][1]}'),
                        subtitle: Text('${csvData![index + 2][2]}'));
                  })),

          // Component #2

          ElevatedButton(
              onPressed: () {
                generateRecommendations();
              },
              child: Text('Recommendation')),

          // Component #3

          Expanded(
              child: recommendedSongs == null
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: recommendedSongs!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(recommendedSongs![index][0]),
                            subtitle: Text(recommendedSongs![index][1]));
                      }))
        ],
      ),
    );
  }
}
