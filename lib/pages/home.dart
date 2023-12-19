import 'package:flutter/material.dart';
import 'package:sked/pages/custom_navigation_bar.dart';
import 'package:sked/pages/funciones.dart';
import 'package:sked/pages/funciones_pasadas.dart';
import 'package:sked/pages/pelicula_individual.dart';
import 'package:sked/pages/peliculas.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _pages = [
      Peliculas(onBodyChanged: navigateBottomBar),
      const Funciones(),
      const FuncionesPasadas(),
      const PeliculaIndividual(),
    ];
  }

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomNavigationBar(navigateBottomBar),
      extendBody: true,
    );
  }
}
