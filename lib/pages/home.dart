import 'package:flutter/material.dart';
import 'package:sked/pages/custom_navigation_bar.dart';
import 'package:sked/pages/funciones.dart';
import 'package:sked/pages/pelicula_individual.dart';
import 'package:sked/pages/peliculas.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    const Peliculas(),
    const PeliculaIndividual(),
    const Funciones()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: const CustomNavigationBar(),
      extendBody: true,
    );
  }
}
