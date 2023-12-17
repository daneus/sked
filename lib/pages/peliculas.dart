import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/modelo_pelicula.dart';

class Peliculas extends StatelessWidget {
  const Peliculas({super.key});

  @override
  Widget build(BuildContext context) {
    List<ModeloPelicula> parseMovies(String responseBody) {
      List<dynamic> jsonData = json.decode(responseBody);
      return jsonData.map((json) => ModeloPelicula.fromJson(json)).toList();
    }

    Future<List<ModeloPelicula>> fetchMovies() async {
      final response =
          await http.get(Uri.parse('http://192.168.18.12:3000/cartelera'));
      if (response.statusCode == 200) {
        return parseMovies(response.body);
      } else {
        throw Exception('Failed to retrieve movies!');
      }
    }

    return Material(
      child: Scaffold(
        body: Container(
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
          child: SafeArea(
              child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 15),
                child: const Text(
                  "Películas",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 50),
                ),
              ),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                color: Colors.white,
                child: FutureBuilder<List<ModeloPelicula>>(
                  future: fetchMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error XD: ${snapshot.error}");
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text("No data available!");
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Text(snapshot.data![index].title),
                          );
                        },
                      );
                    }
                  },
                ),
              ))
            ],
          )),
        ),
      ),
    );
  }
}
