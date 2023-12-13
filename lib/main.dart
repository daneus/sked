import 'package:flutter/material.dart';
import 'package:sked/pages/pelicula_individual.dart';
import 'package:sked/pages/home.dart';
import 'package:sked/pages/peliculas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      routes: {
        "/peliculas": (context) => const Peliculas(),
        "/peliculaIndividual": (context) => const PeliculaIndividual()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
