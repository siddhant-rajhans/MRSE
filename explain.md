Sure! Here's a proper documentation for this Flutter app:

## Song Recommender App

This is a Flutter app that recommends similar songs based on the user-selected song titles. The app uses CSV data to display a list of available songs and allows users to select some of them. Then, it sends selected song titles as JSON data using HTTP POST request to Flask API hosted locally at 127.0.0:5000/predict endpoint and waits until response comes back with recommended songs list also in JSON format.

### Dependencies

The following dependencies are required for this project:

- `flutter/material.dart`: Provides widgets for material design.
- `flutter/services.dart` : provides rootBundle object which can be used to access assets files stored under assets folder.
- `dart:async`: Provides asynchronous programming tools.
- `dart:convert`: Provides functions for converting between JSON strings and objects
- `http/http.dart`: Provides functions for making http requests.
- 'package:csv/csv.dart': Package that converts csv string into List<List<dynamic>> where each row represent as List<dynamic>

### Classes

#### Stateful Widget Class - SongRecommender

The main class of the app is called SongRecommender which extends StatefulWidget class from flutter library.

##### Properties:
 - **songsList** : A list containing all rows read from mini_data.csv file converted into Map<String,dynamic> where keys represent name of columns (title, artist_name) 
 - **suggestions**: A list containing recommended song titles received from Flask API after sending selected song titles using HTTP POST request.

##### Methods:
 - **loadAsset()**: This method loads mini_data.csv file stored under assets folder into memory as string by accessing it through rootBundle object provided by services package.
 - **csvToList(csvData)**: This method accepts csvData(string) parameter and returns List<Map<String,dynamic>> where each row from csv file is represented as Map with keys as column name (title, artist_name).
 - **loadData()**: This method calls loadAsset() and csvToList(csvData) methods to read mini_data.csv file into memory as list of maps(rows). It then updates songsList property by assigning this new value.
 - **_recommendSongs()**: This async method gets called when user clicks "Recommendation" button after selecting some songs from displayed list view widget. It constructs an HTTP POST request to send selected song titles data in JSON format to Flask API hosted locally at 127.0.0:5000/predict endpoint and waits until response comes back with recommended songs list also in JSON format. If successful response received then it updates suggestions property by parsing incoming JSON string.

##### Lifecycle Methods:
- **initState()**: This lifecycle method is overridden here which gets called only once when Stateful Widget is mounted on screen first time.It calls loadData function inside setState(() {}); block so that if we get any error while reading CSV file or converting it's content into List<Map<String,dynamic>> then app will stay alive and keep showing CircularProgressIndicator .

##### Build Method:
The `build()` method returns a Scaffold widget containing two widgets:

1. AppBar
2. Column

The column contains two main widgets:

1. Expanded ListView.builder widget which displays all rows from CSV file converted into Map<String,dynamic> using ListTile widget where each row represent one item in the list view.
2. ElevatedButton widget having text 'Recommendation' which triggers _recommendSongs() function call.

If the `songsList` is null, i.e., loading CSV data not yet finished successfully, it shows a CenteredCircularProgressIndicator instead.


### Example Usage
To run this app you can use either Android Studio or Visual Studio Code IDEs but before running make sure you have installed Flutter SDK on your system along with Android Emulator setup or connected physical device for testing purposes.