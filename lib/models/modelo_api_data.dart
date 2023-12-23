import 'package:sked/models/mode_funcion.dart';
import 'package:sked/models/modelo_futura_pelicula.dart';
import 'package:sked/models/modelo_pelicula.dart';

class ModeloAPIData {
  List<ModeloPelicula>? cartelera;
  List<ModeloFuturaPelicula>? proximamente;
  List<ModeloFuncion>? funciones;

  ModeloAPIData({this.cartelera, this.proximamente, this.funciones});
}
