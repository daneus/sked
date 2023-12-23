import 'package:flutter/material.dart';
import 'package:sked/models/mode_funcion.dart';

class FuncionIndividual extends StatelessWidget {
  final ModeloFuncion? modeloFuncion;
  const FuncionIndividual({super.key, this.modeloFuncion});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Text(modeloFuncion!.screen));
  }
}
