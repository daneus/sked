import 'package:flutter/material.dart';
import 'package:sked/models/modelo_funcion.dart';
import 'package:sked/models/modelo_futura_pelicula.dart';
import 'package:sked/models/modelo_pelicula.dart';
import 'package:sked/pages/custom_navigation_bar.dart';
import 'package:sked/pages/funciones.dart';
import 'package:sked/pages/funciones_pasadas.dart';
import 'package:sked/pages/funcion_individual.dart';
import 'package:sked/pages/futura_pelicula_individual.dart';
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
      Peliculas(
        onBodyChanged: navigateBottomBar,
        onPeliculaSelected: handleModeloPelicula,
        onFuturaPeliculaSelected: handleModeloFuturaPelicula,
      ),
      Funciones(
        onBodyChanged: navigateBottomBar,
        onFuncionSelected: handleModeloFuncion,
      ),
      const FuncionesPasadas(),
      const Placeholder(),
      // FuncionIndividual(onBodyChanged: navigateBottomBar)
      const Placeholder()
    ];
  }

  void handleModeloPelicula(ModeloPelicula peliculaSeleccionada) {
    setState(() {
      _pages[3] = PeliculaIndividual(
        modeloPelicula: peliculaSeleccionada,
        onBodyChanged: navigateBottomBar,
      );
    });
  }

  void handleModeloFuturaPelicula(
      ModeloFuturaPelicula futuraPeliculaSeleccionada) {
    setState(() {
      _pages[3] = FuturaPeliculaIndividual(
        modeloFuturaPelicula: futuraPeliculaSeleccionada,
        onBodyChanged: navigateBottomBar,
      );
    });
  }

  void handleModeloFuncion(ModeloFuncion funcionSeleccionada) {
    setState(() {
      _pages[4] = FuncionIndividual(
        modeloFuncion: funcionSeleccionada,
        onBodyChanged: navigateBottomBar,
      );
    });
  }

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: CustomNavigationBar(navigateBottomBar),
      extendBody: true,
    );
  }
}
