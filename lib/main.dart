// ignore_for_file: library_private_types_in_public_api
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sked/models/modelo_api_data.dart';
import 'package:sked/models/modelo_futura_pelicula.dart';
import 'package:sked/models/modelo_pelicula.dart';
import 'package:http/http.dart' as http;
import 'package:sked/pages/home.dart';

class DataModel extends ChangeNotifier {
  ModeloAPIData? _data;
  ModeloAPIData? get data => _data;

  List<ModeloPelicula> parseMovies(String responseBody) {
    List<dynamic> jsonData = json.decode(responseBody);
    return jsonData.map((json) => ModeloPelicula.fromJson(json)).toList();
  }

  List<ModeloFuturaPelicula> parseFutureMovies(String responseBody) {
    List<dynamic> jsonData = json.decode(responseBody);
    return jsonData.map((json) => ModeloFuturaPelicula.fromJson(json)).toList();
  }

  Future<ModeloAPIData> fetchDataFromAPI() async {
    try {
      if (_data != null) {
        return _data!;
      }
      _data = ModeloAPIData();
      final responseMovies =
          await http.get(Uri.parse('http://192.168.18.12:3000/cartelera'));
      final responseFutureMovies =
          await http.get(Uri.parse('http://192.168.18.12:3000/proximamente'));
      final responseFunctions =
          await http.get(Uri.parse('http://192.168.18.12:3000/cartelera'));

      if (responseMovies.statusCode == 200 &&
          responseFutureMovies.statusCode == 200 &&
          responseFunctions.statusCode == 200) {
        _data!.cartelera = List.of(parseMovies(responseMovies.body));
        _data!.proximamente =
            List.of(parseFutureMovies(responseFutureMovies.body));

        notifyListeners();
        return _data!;
      } else {
        throw Exception(
            'Failed to retrieve movies! Status code: ${responseMovies.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching movies xdd: $error');
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future:
            Provider.of<DataModel>(context, listen: false).fetchDataFromAPI(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: <Color>[
                      Color(0xFFFF9900),
                      Color(0xFFBF001D),
                      Color(0xFFA50F3D),
                      Color(0xFF143A6B),
                      Color(0xFF1F5286),
                      Color(0xFF008DFF)
                    ],
                        stops: <double>[
                      0,
                      0.2,
                      0.33,
                      0.7,
                      0.82,
                      1
                    ])),
                child: const Center(
                    child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 6,
                  ),
                )));
          } else if (snapshot.hasError) {
            return Text("Error XD: ${snapshot.error}");
          } else if (!snapshot.hasData) {
            return const Text("No data available!");
          } else {
            return const Home();
          }
        },
      ),
      theme: ThemeData(fontFamily: 'Avenir'),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => DataModel(), child: const MyApp()),
  );
}
