import 'package:flutter/material.dart';
import 'package:csv/csv.dart' as csv;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<List<dynamic>> csvData = [];
  int selectedIndex = -1;
  String recommendationOutput = '';

// This function loads CSV data from assets into memory.
  Future<void> loadCSV() async {
    final String response = await rootBundle.loadString('assets/mini_data.csv');
    setState(() {
      csvData = csv.CsvToListConverter().convert(response);
      // Only keep the first two columns (title and release) in each row and remove song id column.
      for (int i = 0; i < csvData.length; i++) {
        csvData[i] = [csvData[i][1], csvData[i][2]];
      }
    });
  }

// Function to send u_uid and selected song_id to API.
  Future<void> recommendSong(String songId, String userId) async {
    final url = Uri.parse('http://localhost:5000/recommend');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, dynamic>{"u_uid": userId, "song_id": songId}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          recommendationOutput =
              'Recommended song titles: ${data['recommended_song_title'].join(', ')}';
        });
      } else {
        throw Exception('Failed to send recommendation.');
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    loadCSV(); // Load CSV on app start.
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Song Recommender',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.black,
            appBar:
                AppBar(title: const Center(child: Text("Song Recommender"))),
            body: Column(children: [
              Expanded(
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                    Container(
                        height: MediaQuery.of(context).size.height / 3.5,
                        width: MediaQuery.of(context).size.width / 1.1,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(227, 255, 255, 255)),
// Displaying loaded CSV data with only Title and Release Date column using ListView builder widget.
                        child: (csvData.length == 0)
                            ? const CircularProgressIndicator()
                            : ListView.builder(
                                itemCount: csvData.length - 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      child: Container(
                                          color: (selectedIndex == index)
                                              ? const Color.fromARGB(
                                                  255, 0, 140, 255)
                                              : null,
                                          child: Row(children: [
                                            Expanded(
                                                child: Text(
                                                    csvData[index + 1][0]
                                                        .toString(),
                                                    textAlign: TextAlign.left)),
                                            Expanded(
                                                child: Text(
                                                    csvData[index + 1][1]
                                                        .toString(),
                                                    textAlign: TextAlign.right))
                                          ])));
                                })),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedIndex >= 0) {
                          recommendSong(selectedIndex.toString(),
                              "b80344d063b5ccb3212f76538f3d9e43d87dca9e");
                        }
                      },
                      child: const Text("Recommend"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              (selectedIndex >= 0)
                                  ? Color.fromRGBO(0, 68, 255, 1)
                                  : Colors.grey),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                              TextStyle(fontSize: 16))),
                    ),
                    SizedBox(height: 10),
                    Text(recommendationOutput,
                        style: TextStyle(
                            color: (recommendationOutput != '')
                                ? Colors.greenAccent
                                : null))
                  ]))),
            ])));
  }
}
