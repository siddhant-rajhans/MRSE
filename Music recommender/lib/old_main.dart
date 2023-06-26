import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http; // add this import statement
import 'package:csv/csv.dart';

class SongRecommender extends StatefulWidget {
  const SongRecommender({super.key});

  @override
  _SongRecommenderState createState() => _SongRecommenderState();
}

class _SongRecommenderState extends State<SongRecommender> {
  List<dynamic> songsList = [];

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/mini_data.csv');
  }

  void loadData() {
    loadAsset().then((csvData) {
      setState(() {
        songsList = csvToList(csvData);
      });
    });
  }

  List<dynamic> csvToList(String csvData) {
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(csvData);
    return rowsAsListOfValues
        .sublist(1)
        .map((e) => {'title': e[0], 'artist_name': e[1], 'isSelected': false})
        .toList(); // convert each row into map with keys as column name (title, artist_name)
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (songsList != null) {
      return Scaffold(
          appBar: AppBar(),
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
              child: ListView.builder(
                itemCount: songsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(songsList[index]['title']),
                    subtitle: Text(songsList[index]['artist_name']),
                    trailing: Checkbox(
                        value: songsList[index]['isSelected'],
                        onChanged: (value) {
                          setState(() {
                            songsList[index]['isSelected'] = value;
                          });
                        }),
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: _recommendSongs,
                child: const Text('Recommendation')),
          ]));
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  List<String> suggestions = [];

  Future<void> _recommendSongs() async {
    // convert list of maps to list of song titles

    List<String> selectedSongTitles = songsList
        .where((e) => e['isSelected'])
        .map((e) => e['title'].toString())
        .toList();

    // call flask api to get recommendations for selected song titles.

    var response = await http.post(
        Uri.parse(
            "http://127.0.0.1:5000/predict"), // Use Uri.parse to convert the URL string to a Uri object
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'songs': selectedSongTitles}));

    if (response.statusCode == 200) {
      setState(() {
        suggestions =
            List<String>.from(json.decode(response.body)['recommendations']);
        print(suggestions);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
}
