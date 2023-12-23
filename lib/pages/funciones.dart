import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sked/main.dart';
import 'package:sked/models/mode_funcion.dart';

class Funciones extends StatefulWidget {
  final Function(int) onBodyChanged;
  final Function(ModeloFuncion) onFuncionSelected;
  const Funciones(
      {super.key,
      required this.onBodyChanged,
      required this.onFuncionSelected});

  @override
  State<Funciones> createState() => _FuncionesState();
}

class _FuncionesState extends State<Funciones> {
  @override
  Widget build(BuildContext context) {
    final dataModel = Provider.of<DataModel>(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: FutureBuilder(
          future: dataModel.fetchDataFromAPI(),
          builder: (context, snapshot) {
            final List<ModeloFuncion> functions =
                snapshot.data?.funciones ?? [];
            return ListView.builder(
              itemCount: functions.length,
              itemBuilder: (context, index) {
                final function = functions[index];
                return GestureDetector(
                    onTap: () {
                      widget.onBodyChanged(4);
                      widget.onFuncionSelected(function);
                    },
                    child: Text(function.title));
              },
            );
          },
        ),
      ),
    );
  }
}
