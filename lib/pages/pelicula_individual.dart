import 'package:flutter/material.dart';
import 'package:sked/models/modelo_pelicula.dart';

class PeliculaIndividual extends StatelessWidget {
  final ModeloPelicula? modeloPelicula;

  const PeliculaIndividual({required this.modeloPelicula, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: modeloPelicula != null
            //What will render if not null
            ? Text(modeloPelicula!.title)
            //DON'T LOOK AT THIS IT'S UGLY
            : const Text("ModeloPelicula is null"),
      ),
    );
  }
}
