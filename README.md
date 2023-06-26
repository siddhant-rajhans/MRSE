# MRSE
Songs Recommender is a Flutter app integrated with a Flask API that provides song recommendations based on user selections. The Flutter app allows users to browse a list of songs and get personalized recommendations by sending data to the Flask API.
# Songs Recommender
Songs Recommender is a Flutter app integrated with a Flask API that provides song recommendations based on user selections. The Flutter app allows users to browse a list of songs and get personalized recommendations by sending data to the Flask API.

## Features

- Displays a list of songs from a CSV file
- Allows users to select a song and request recommendations
- Integrates with a Flask API to process user data and generate recommendations

## Technologies Used

- Flutter: a cross-platform UI toolkit for building natively compiled applications
- Flask: a micro web framework for building Python web applications
- Pandas: a library for data manipulation and analysis in Python

## Setup Instructions

### Flutter App

1. Make sure you have Flutter installed. If not, follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install) for your operating system.
2. Clone this repository to your local machine.
3. Open the Flutter project in your preferred IDE or editor.
4. Update the `lib/main.dart` file with the appropriate CSV file path in the `loadSongData()` function.
5. Run the Flutter app using the command `flutter run`.

### Flask API

1. Make sure you have Python 3 installed. If not, download and install it from the [official Python website](https://www.python.org/downloads/).
2. Clone this repository to your local machine (if not already done).
3. Navigate to the Flask API directory.
4. Create a virtual environment by running the command `python3 -m venv venv`.
5. Activate the virtual environment:
   - For Windows: `venv\Scripts\activate`
   - For macOS/Linux: `source venv/bin/activate`
6. Install the required dependencies by running the command `pip install -r requirements.txt`.
7. Place your CSV file in the same directory as `app.py` and name it `song_data.csv`.
8. Run the Flask API using the command `python app.py`.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvement, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

